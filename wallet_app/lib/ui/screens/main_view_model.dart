
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:wallet_app/repository/dto/login_user_data.dart';
import 'package:wallet_app/repository/dto/planning.dart';
import 'package:wallet_app/repository/dto/transaction.dart';
import 'package:wallet_app/repository/dto/user.dart';
import 'package:wallet_app/repository/user_repository.dart';
import 'package:wallet_app/shared_preferences/user_local_storage.dart';

class MainViewModel extends ChangeNotifier {
  final UserRepository userRepository = UserRepository();
  final UserLocalStorage userLocalStorage = UserLocalStorage();

  User _userData = User(
   planning: Planning()
  );
  bool _showNetworkErrorSnackBar = false;

  String _errorMessage = "";

  get userData => _userData;
  get showNetworkErrorSnackBar => _showNetworkErrorSnackBar;
  get errorMessage => _errorMessage;

  void setUserData(User user) {
    _userData = user;
    notifyListeners();
  }

  Future<bool?> login(String email, String password) async {
    try {
      final user = await userRepository.login(LoginUserData(email: email, password: password));
      _userData = user.data!;
      userLocalStorage.saveUser(_userData);
      _showNetworkErrorSnackBar = false;
      notifyListeners();

      return true;
    } catch (e) {
      _showNetworkErrorSnackBar = true;
      _errorMessage = e.toString();
      notifyListeners();

      return false;
    }
  }

  Future<bool?> addUser(String email, String password, String name) async {
    try {
      final user = await userRepository.addUser(User(
          email: email,
          password: password,
          name: name,
          planning: Planning()
      ));
      _userData = user.data!;
      userLocalStorage.saveUser(_userData);
      _showNetworkErrorSnackBar = false;
      notifyListeners();
      return true;
    } catch (e) {
      _showNetworkErrorSnackBar = true;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    try {
      _userData = User(
          planning: Planning()
      );
      userLocalStorage.deleteUser();
      _showNetworkErrorSnackBar = false;
    } catch (e) {
      _showNetworkErrorSnackBar = true;
    }
    notifyListeners();
  }


  Future<void> addTransaction(String transactionType, double amount, String selectedCategory, String description, bool income) async {
    try {
      amount = transactionType == "income" ? amount : -amount;
      final user = await userRepository.addTransaction(Transaction(
       category: selectedCategory,
        description: description,
        expense: !income,
        value: amount
      ), _userData.id);
      _userData = user.data!;
      userLocalStorage.saveUser(_userData);
      _showNetworkErrorSnackBar = false;
    } catch (e) {
      _showNetworkErrorSnackBar = true;
    }
    notifyListeners();
  }

}




// private val repository = UserRepository(test = false)
//
// var email by mutableStateOf("")
// var password by mutableStateOf("")
// var name by mutableStateOf("")
//
// var userData: User by mutableStateOf(User())
// var showNetworkErrorSnackBar by mutableStateOf(false)
//
// var msg_boardID by mutableStateOf("")
// var msg_boardIdError by mutableStateOf(false)
// var errorMessage by mutableStateOf("")

// class MainViewModel extends ChangeNotifier {
//   final BoardRepository boardRepository = BoardRepository();
//
//   int _numberOfBoards = 0;
//   List<Board> _boards = [];
//   Board? _selectedBoard;
//   StreamSubscription<Board>? _boardStreamSubscription;
//
//   get numberOfBoards => _numberOfBoards;
//   get boards => _boards;
//   get selectedBoard => _selectedBoard;
//
//   Future<void> getBoards() async {
//     print("MainViewModel - getBoards()");
//     _numberOfBoards = 0;
//     _boards = [];
//     notifyListeners();
//     // simulate a slower request
//     await Future.delayed(const Duration(seconds: 2));
//     final boards = await boardRepository.getBoards();
//     print("MainViewModel - getBoards() $boards");
//     _numberOfBoards = boards.length;
//     _boards = boards;
//     notifyListeners();
//
//     startContinousCollection();
//   }
//
//   Future<void> startContinousCollection() async {
//     var streamsOfBoards =
//     boardRepository.getBoardsContinously(Duration(seconds: 4));
//     await for (var newBoards in streamsOfBoards) {
//       print(newBoards);
//       _numberOfBoards = newBoards.length;
//       _boards = newBoards;
//       notifyListeners();
//     }
//   }
//
//   void selectBoardForMessages(Board board) {
//     print("Selected board: $board");
//     _selectedBoard = board;
//     startMonitoringForBoard();
//   }
//
//   void startMonitoringForBoard() {
//     // send requests for board.id every 500ms
//     var stream = boardRepository.getBoardContinously(
//         _selectedBoard!.id!, Duration(milliseconds: 500));
//
//     _boardStreamSubscription = stream.listen((board) {
//       _selectedBoard = board;
//     });
//   }
//
//   void stopMonitoringForBoard() {
//     print('stopMonitoringForBoard');
//     _boardStreamSubscription?.cancel();
//     boardRepository.stopStreamingBoard();
//   }
//
//   Future<void> postMessage(
//       int boardId, String from, String to, String textMessage) async {
//     var message = Message(
//         from: from.trim().isEmpty ? "anonymous" : from.trim(),
//         to: to.trim().isEmpty ? "anonymous" : to.trim(),
//         text: textMessage,
//         timestamp: "");
//     boardRepository.postMessage(boardId, message);
//   }
// }