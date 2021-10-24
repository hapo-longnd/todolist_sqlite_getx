import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:reorderables/reorderables.dart';
import 'package:todolist_sqlite_getx/controllers/home.controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController _homeController = Get.put(HomeController());
  final _searchController = TextEditingController();

  Future<void> _showDialogSortOption() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              _homeController.listOptionSortListTodo.length,
              (index) => GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    _homeController.listOptionSortListTodo[index],
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildRowTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Task Management",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        const SizedBox(
          width: 30,
        ),
        Row(
          children: List.generate(
            _homeController.listTypeShowListTodo.length,
            (index) => GestureDetector(
              onTap: () {
                _homeController.switchTypeShowListTodo();
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(color: Colors.grey.withOpacity(0.5), width: 1),
                ),
                child: Obx(() {
                  return Text(
                    _homeController.listTypeShowListTodo[index],
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: _homeController.typeShowListTodo.value == index
                          ? Colors.black
                          : Colors.black.withOpacity(0.3),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRowSearchSortOption() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              child: TextFormField(
                controller: _searchController,
                textAlign: TextAlign.start,
                strutStyle: const StrutStyle(
                  fontSize: 18,
                ),
                style: const TextStyle(fontSize: 18, color: Colors.black),
                autocorrect: false,
                decoration: const InputDecoration(
                  labelText: "Search task",
                  labelStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  floatingLabelStyle: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 5.0),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
          ),
          Row(
            children: [
              PopupMenuButton(
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    child: Text("All"),
                    value: 1,
                  ),
                  const PopupMenuItem(
                    child: Text("10 task"),
                    value: 2,
                  ),
                  const PopupMenuItem(
                    child: Text("30 task"),
                    value: 3,
                  ),
                  const PopupMenuItem(
                    child: Text("50 task"),
                    value: 4,
                  )
                ],
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Text(
                        "Show: ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      Obx(() {
                        return Text(
                          _homeController.optionSelectedShowListTodo.value,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        );
                      }),
                      Container(
                        margin: const EdgeInsets.only(left: 40),
                        child: const Icon(
                          Icons.arrow_drop_down,
                          size: 30,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                onSelected: (index) {
                  if (index == 1) {
                    _homeController.selectOptionShowListTodo("All");
                  } else if (index == 2) {
                    _homeController.selectOptionShowListTodo("10 task");
                  } else if (index == 3) {
                    _homeController.selectOptionShowListTodo("30 task");
                  } else {
                    _homeController.selectOptionShowListTodo("50 task");
                  }
                },
              )
            ],
          ),
          GestureDetector(
            onTap: () async {
              await _showDialogSortOption();
            },
            child: Container(
              margin: const EdgeInsets.only(left: 16),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.5),
                ),
              ),
              child: const Icon(
                Icons.swap_vert,
                size: 40,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleTable(int expand, String title , int position) {
    return Expanded(
      flex: expand,
      child: Container(
        alignment: position == 0 ? Alignment.centerLeft : Alignment.center,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildTitleTableTodoList() {
    return Container(
      margin: const EdgeInsets.only(top: 32),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          _buildTitleTable(8, "Task" , 0),
          _buildTitleTable(2, "End Date" , 0),
          _buildTitleTable(3, "Status" , 1),
          _buildTitleTable(2, "Priority" , 1),
          _buildTitleTable(2, "Progress" , 1),
          _buildTitleTable(1, "" , 0),
        ],
      ),
    );
  }

  Widget _buildButtonAddNewTask() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: DottedBorder(
        color: Colors.lightGreenAccent,
        strokeWidth: 3,
        radius: const Radius.circular(8),
        dashPattern: const [10, 10],
        child: Container(
          height: 50,
          padding: const EdgeInsets.only(left: 16),
          child: Row(
            children: const [
              Icon(
                Icons.add,
                size: 30,
                color: Colors.lightGreenAccent,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                "Add New Task",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContentTodoList() {
    List<Widget> _listTodoWidget = List.generate(
      _homeController.listTodoFakeData.length,
      (index) {
        Map<String, dynamic> todo = _homeController.listTodoFakeData[index];
        return Container(
          key: ValueKey(todo),
          margin: const EdgeInsets.symmetric(vertical: 2),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 6,
                child: Text(
                  todo["title"],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  todo["dateFinish"].split(" ")[0],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: todo["status"] == 0
                        ? Colors.orange
                        : todo["status"] == 1
                            ? Colors.blue
                            : todo["status"] == 2
                                ? Colors.red
                                : todo["status"] == 3
                                    ? Colors.green
                                    : Colors.deepOrange,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    todo["status"] == 0
                        ? "Not Started"
                        : todo["status"] == 1
                            ? "In Progress"
                            : todo["status"] == 2
                                ? "Cancelled"
                                : todo["status"] == 3
                                    ? "Completed"
                                    : "Pause",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      child: Icon(
                        Icons.flag,
                        size: 24,
                        color: todo["priority"] == 0
                            ? Colors.red
                            : todo["priority"] == 1
                                ? Colors.green
                                : Colors.lightBlueAccent,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: CircularPercentIndicator(
                  radius: 60.0,
                  lineWidth: 5.0,
                  percent:
                      _homeController.listTodoFakeData[index]["progress"] / 100,
                  center: Text(
                      "${_homeController.listTodoFakeData[index]["progress"]}%"),
                  progressColor: Colors.green,
                ),
              ),
              Expanded(
                flex: 1,
                child: PopupMenuButton(
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      child: Text("Update Task"),
                      value: 1,
                    ),
                    const PopupMenuItem(
                      child: Text("Delete Task"),
                      value: 2,
                    ),
                  ],
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: const Icon(
                      Icons.more_vert,
                      size: 35,
                      color: Colors.grey,
                    ),
                  ),
                  onSelected: (index) {
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
    return ReorderableColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _listTodoWidget,
      onReorder: (oldIndex, newIndex) {
        // Widget row = _rows.removeAt(oldIndex);
        // _rows.insert(newIndex, row);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          margin: const EdgeInsets.only(top: 40),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              _buildRowTitle(),
              _buildRowSearchSortOption(),
              _buildTitleTableTodoList(),
              _buildButtonAddNewTask(),
              _buildContentTodoList(),
            ],
          ),
        ),
      ),
    );
  }
}
