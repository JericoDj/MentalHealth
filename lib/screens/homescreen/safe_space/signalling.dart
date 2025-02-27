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
  Future<void> openUserMedia(RTCVideoRenderer localVideo, RTCVideoRenderer remoteVideo) async {
    localStream = await navigator.mediaDevices.getUserMedia({'video': true, 'audio': true});
    localVideo.srcObject = localStream;
    remoteVideo.srcObject = await createLocalMediaStream('remote');
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
    localStream?.getTracks().forEach((track) => track.stop());
    remoteStream?.getTracks().forEach((track) => track.stop());

    peerConnection?.close();

    localStream?.dispose();
    remoteStream?.dispose();
  }

  void _registerPeerConnectionListeners() {
    peerConnection?.onAddStream = (MediaStream stream) {
      onAddRemoteStream?.call(stream);
      remoteStream = stream;
    };
  }
}
