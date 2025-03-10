// call_controller.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import '../test/test/services/webrtc_service.dart'; // Adjust the import path as needed

class CallController {
  final WebRtcService fbCallService;
  final Function(String) onRoomIdGenerated;
  final Function() onCallEnded;
  final Function() onConnectionEstablished;
  final Function() onStateChanged; // Notify UI when state changes

  RTCPeerConnection? peerConnection;
  final RTCVideoRenderer localVideo = RTCVideoRenderer();
  final RTCVideoRenderer remoteVideo = RTCVideoRenderer();
  MediaStream? localStream;

  bool isAudioOn = true;
  bool isVideoOn = true;
  bool isFrontCameraSelected = true;

  CallController({
    required this.fbCallService,
    required this.onRoomIdGenerated,
    required this.onCallEnded,
    required this.onConnectionEstablished,
    required this.onStateChanged, // Pass state change callback
  });

  Future<void> init(String? roomId) async {
    try {
      await remoteVideo.initialize();

      // Set up remote stream handling
      peerConnection?.onTrack = (event) {
        if (event.track.kind == 'video') {
          remoteVideo.srcObject = event.streams.first;
          onConnectionEstablished();
        }
      };

      if (roomId == null) {
        // Create a new call
        String newRoomId = await fbCallService.call();
        onRoomIdGenerated(newRoomId);
        iceStatusListen();
      } else {
        // Join an existing call
        await fbCallService.answer(roomId: roomId);
        iceStatusListen();
      }
    } catch (e) {
      debugPrint("************** CallController.init: $e");
    }
  }

  Future<void> openCamera() async {
    await localVideo.initialize();
    peerConnection = await fbCallService.createPeer();

    final Map<String, dynamic> mediaConstraints = {
      'audio': isAudioOn,
      'video': isVideoOn,
    };

    // Get user media (camera and microphone)
    localStream = await navigator.mediaDevices.getUserMedia(mediaConstraints);

    // Add tracks to the peer connection
    localStream!.getTracks().forEach((track) async {
      await peerConnection?.addTrack(track, localStream!);
    });

    // Set the local video source
    localVideo.srcObject = localStream;
  }

  void iceStatusListen() {
    peerConnection?.onIceConnectionState = (iceConnectionState) async {
      if (iceConnectionState == RTCIceConnectionState.RTCIceConnectionStateConnected ||
          iceConnectionState == RTCIceConnectionState.RTCIceConnectionStateCompleted) {
        onConnectionEstablished();
      }

      if (iceConnectionState == RTCIceConnectionState.RTCIceConnectionStateDisconnected ||
          iceConnectionState == RTCIceConnectionState.RTCIceConnectionStateFailed) {
        onCallEnded();
      }
    };
  }

  void toggleMic() {
    isAudioOn = !isAudioOn;
    localStream?.getAudioTracks().forEach((track) {
      track.enabled = isAudioOn;
    });
    onStateChanged(); // Notify UI
  }



  void toggleCamera() {
    isVideoOn = !isVideoOn;
    localStream?.getVideoTracks().forEach((track) {
      track.enabled = isVideoOn;
    });
  }

  void switchCamera() {
    isFrontCameraSelected = !isFrontCameraSelected;
    localStream?.getVideoTracks().forEach((track) {
      // ignore: deprecated_member_use
      track.switchCamera();
    });
  }

  void dispose() async {
    peerConnection?.close();
    localStream?.getTracks().forEach((track) {
      track.stop();
    });
    await localVideo.dispose();
    await remoteVideo.dispose();
    localStream?.dispose();
    peerConnection?.dispose();
  }
}