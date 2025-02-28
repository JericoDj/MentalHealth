import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

typedef void StreamStateCallback(MediaStream stream);

class Signaling {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  RTCPeerConnection? peerConnection;
  MediaStream? localStream;
  MediaStream? remoteStream;
  StreamStateCallback? onAddRemoteStream;

  final Map<String, dynamic> configuration = {
    'iceServers': [
      {'urls': 'stun:stun.l.google.com:19302'},
    ]
  };

  // ✅ Open Camera & Mic
  Future<MediaStream?> openUserMedia(RTCVideoRenderer localRenderer, RTCVideoRenderer remoteRenderer) async {
    try {
      final Map<String, dynamic> constraints = {
        "audio": true,
        "video": {
          "mandatory": {
            "minWidth": 640,
            "minHeight": 480,
            "minFrameRate": 30,
          },
          "facingMode": "user", // 🔥 Ensure this is a string, not a HashMap!
        }
      };

      MediaStream stream = await navigator.mediaDevices.getUserMedia(constraints);

      localRenderer.srcObject = stream;
      return stream;
    } catch (e) {
      print("❌ Error opening user media: $e");
      return null;
    }
  }




  // ✅ Join Room
  Future<void> joinRoom(String roomId, RTCVideoRenderer remoteRenderer) async {
    DocumentReference roomRef = db.collection('safe_space/video_calls').doc(roomId);
    var roomSnapshot = await roomRef.get();

    if (roomSnapshot.exists) {
      peerConnection = await createPeerConnection(configuration);
      _registerPeerConnectionListeners();

      localStream?.getTracks().forEach((track) {
        peerConnection?.addTrack(track, localStream!);
      });

      var calleeCandidatesCollection = roomRef.collection('calleeCandidates');
      peerConnection!.onIceCandidate = (RTCIceCandidate candidate) {
        calleeCandidatesCollection.add(candidate.toMap());
      };

      var data = roomSnapshot.data() as Map<String, dynamic>;
      var offer = data['offer'];

      await peerConnection?.setRemoteDescription(
        RTCSessionDescription(offer['sdp'], offer['type']),
      );

      var answer = await peerConnection!.createAnswer();
      await peerConnection!.setLocalDescription(answer);

      await roomRef.update({"answer": answer.toMap(), "status": "ongoing"});

      roomRef.collection('callerCandidates').snapshots().listen((snapshot) {
        for (var change in snapshot.docChanges) {
          var data = change.doc.data() as Map<String, dynamic>;
          peerConnection!.addCandidate(
            RTCIceCandidate(data['candidate'], data['sdpMid'], data['sdpMLineIndex']),
          );
        }
      });
    }
  }

  // ✅ End Call & Cleanup
  Future<void> hangUp(RTCVideoRenderer localVideo) async {
    if (localStream != null) {
      for (var track in localStream!.getTracks()) {
        track.stop(); // ✅ Stop all media tracks
      }
      localStream = null; // ✅ Clear the stream
    }

    if (remoteStream != null) {
      for (var track in remoteStream!.getTracks()) {
        track.stop();
      }
      remoteStream = null;
    }

    peerConnection?.close(); // ✅ Properly close PeerConnection
    peerConnection = null;
  }


  void _registerPeerConnectionListeners() {
    peerConnection?.onAddStream = (MediaStream stream) {
      onAddRemoteStream?.call(stream);
      remoteStream = stream;
    };
  }
}
