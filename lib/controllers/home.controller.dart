import 'package:get/get.dart';

class HomeController extends GetxController {
  List<String> listTypeShowListTodo = ["List", "Grid"];
  var typeShowListTodo = 0.obs;

  switchTypeShowListTodo() {
    if (typeShowListTodo.value == 0) {
      typeShowListTodo.value = 1;
    } else {
      typeShowListTodo.value = 0;
    }
  }

  // ================================================

  List<String> listOptionShowListTodo = ["All", "10", "30", "50"];
  var optionSelectedShowListTodo = "All".obs;

  selectOptionShowListTodo(String option) {
    optionSelectedShowListTodo.value = option;
  }

  // ================================================

  List<String> listOptionSortListTodo = [
    "Mặc định",
    "Tăng dần theo tên công việc",
    "Giảm dần theo tên công việc",
    "Tăng dần theo ngày bắt đầu",
    "Giảm dần theo ngày bắt đầu",
    "Tăng dần theo ngày kết thúc",
    "Giảm dần theo ngày kết thúc",
    "Tăng dần theo % khối lượng công việc",
    "Giảm dần theo % khối lượng công việc",
  ];

  // ================================================

  List<Map<String , dynamic>> listTodoFakeData = [
    {
      "id": 0,
      "title": "Tiêu đề 0",
      "content": "Nội dung",
      "dateCreate": "20/10/2021 10:20:45",
      "dateStart": "20/10/2021 10:20:45",
      "dateFinish": "20/10/2021 10:20:45",
      "status": 0,
      "priority": 0,
      "progress": 35
    },
    {
      "id": 1,
      "title": "Tiêu đề 1",
      "content": "Nội dung",
      "dateCreate": "20/10/2021 10:20:45",
      "dateStart": "20/10/2021 10:20:45",
      "dateFinish": "20/10/2021 10:20:45",
      "status": 1,
      "priority": 1,
      "progress": 35
    },
    {
      "id": 2,
      "title": "Tiêu đề 2",
      "content": "Nội dung",
      "dateCreate": "20/10/2021 10:20:45",
      "dateStart": "20/10/2021 10:20:45",
      "dateFinish": "20/10/2021 10:20:45",
      "status": 2,
      "priority": 2,
      "progress": 35
    }
  ];

  // ================================================
}
