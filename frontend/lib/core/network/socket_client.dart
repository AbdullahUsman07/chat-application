
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketClient{
    io.Socket? _socket;

    bool get isConnected => _socket?.connected ?? false;
    String? get socketID => _socket?.id;

    // Established Websocket Connection with JWT authpayload
    void connect(String serverUrl, String token){
        if(_socket != null && _socket!.connected) return;

        _socket = io.io(
            serverUrl,
            io.OptionBuilder()
                .setTransports(['websocket', 'polling'])
                .disableAutoConnect()
                .setAuth({'token':token})
                .build(),
        );

        _socket?.connect();
        
        _socket?.onConnect((_){
            print('[SocketClient] Connected to gateway. Socket ID: ${_socket?.id}');
        });

        _socket?.onDisconnect((_){
            print('[SocketClient]  Disconnected From Server');
        });

        _socket?.onConnectError((data){
            print('[SocketClient] Connection Error: $data');
        });

        _socket?.onError((data){
            print('[SocketClient] Socket Error: $data');
        });
    }

    void disconnect(){
        _socket?.disconnect();
        _socket = null;
    }

    void emit(String event, dynamic data){
        _socket?.emit(event, data);
    }

    void on(String event, Function(dynamic) handler){
        _socket?.on(event, handler);
    }

}