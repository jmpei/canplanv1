import '../models/category.dart';
import '../models/task.dart';
import '../models/task_step.dart';
import '../models/schedule_instance.dart';

/// Hardcoded sample data mirroring the real app's bundled demo tasks.
/// Swap this out for a real data source later; the providers and UI don't care.
class SampleData {
  SampleData._();

  static const String _img = 'assets/images';
  static const String _stepImg = 'assets/images/sample_task_images';

  static const List<Category> categories = [
    Category(id: 'c_kitchen', name: 'Kitchen', imageAsset: '$_img/29-plainface.png'),
    Category(id: 'c_laundry', name: 'Laundry', imageAsset: '$_img/list2.png'),
    Category(id: 'c_personal', name: 'Personal', imageAsset: '$_img/27-happyface.png'),
  ];

  static const List<Task> tasks = [
    Task(
      id: 't_coffee',
      name: 'Make Nespresso Coffee',
      categoryId: 'c_kitchen',
      imageAsset: '$_stepImg/makecoffeestart.jpg',
      mood: 3,
      sampleTask: true,
      steps: [
        TaskStep(id: 's_c1', order: 1, text: 'Fill the water tank.', imageAsset: '$_stepImg/makecoffeestep1.jpg'),
        TaskStep(id: 's_c2', order: 2, text: 'Turn on the machine.', imageAsset: '$_stepImg/makecoffeestep2.jpg'),
        TaskStep(id: 's_c3', order: 3, text: 'Open the capsule slot.', imageAsset: '$_stepImg/makecoffeestep3.jpg'),
        TaskStep(id: 's_c4', order: 4, text: 'Insert a coffee capsule.', imageAsset: '$_stepImg/makecoffeestep4.jpg'),
        TaskStep(id: 's_c5', order: 5, text: 'Close the slot.', imageAsset: '$_stepImg/makecoffeestep5.jpg'),
        TaskStep(id: 's_c6', order: 6, text: 'Place a cup underneath.', imageAsset: '$_stepImg/makecoffeestep6.jpg'),
        TaskStep(id: 's_c7', order: 7, text: 'Press the brew button.', imageAsset: '$_stepImg/makecoffeestep7.jpg'),
        TaskStep(id: 's_c8', order: 8, text: 'Wait for the cup to fill.', imageAsset: '$_stepImg/makecoffeestep8.jpg'),
        TaskStep(id: 's_c9', order: 9, text: 'Enjoy your coffee!', imageAsset: '$_stepImg/makecoffeestep9.jpg'),
      ],
    ),
    Task(
      id: 't_wash',
      name: 'Wash Clothes',
      categoryId: 'c_laundry',
      imageAsset: '$_stepImg/washclothesstart.jpg',
      mood: 2,
      sampleTask: true,
      steps: [
        TaskStep(id: 's_w1', order: 1, text: 'Sort the laundry.', imageAsset: '$_stepImg/washclothesstep1.jpg'),
        TaskStep(id: 's_w2', order: 2, text: 'Load clothes into the machine.', imageAsset: '$_stepImg/washclothesstep2.jpg'),
        TaskStep(id: 's_w3', order: 3, text: 'Add detergent.', imageAsset: '$_stepImg/washclothesstep3.jpg', useRecording: true),
        TaskStep(id: 's_w4', order: 4, text: 'Select the wash cycle.', imageAsset: '$_stepImg/washclothesstep4.jpg'),
        TaskStep(id: 's_w5', order: 5, text: 'Start the machine.', imageAsset: '$_stepImg/washclothesstep5.jpg'),
        TaskStep(id: 's_w6', order: 6, text: 'Hang the clothes to dry.', imageAsset: '$_stepImg/washclothesstep6.jpg'),
      ],
    ),
    Task(
      id: 't_charge',
      name: 'Charge Phone',
      categoryId: 'c_personal',
      imageAsset: '$_stepImg/chargephonestart.jpg',
      mood: 1,
      sampleTask: true,
      steps: [
        TaskStep(id: 's_p1', order: 1, text: 'Find the charging cable.'),
        TaskStep(id: 's_p2', order: 2, text: 'Plug the charger into the wall.'),
        TaskStep(id: 's_p3', order: 3, text: 'Connect the cable to your phone.'),
        TaskStep(id: 's_p4', order: 4, text: 'Check that the battery icon shows charging.'),
      ],
    ),
  ];

  /// Calendar to-do instances spread around today.
  static List<ScheduleInstance> schedule() {
    final now = DateTime.now();
    DateTime day(int offset) => DateTime(now.year, now.month, now.day + offset, 9);
    return [
      ScheduleInstance(id: 'sch1', taskId: 't_coffee', dueDate: day(0), status: ScheduleStatus.completed),
      ScheduleInstance(id: 'sch2', taskId: 't_wash', dueDate: day(0)),
      ScheduleInstance(id: 'sch3', taskId: 't_charge', dueDate: day(0)),
      ScheduleInstance(id: 'sch4', taskId: 't_coffee', dueDate: day(1)),
      ScheduleInstance(id: 'sch5', taskId: 't_wash', dueDate: day(2)),
      ScheduleInstance(id: 'sch6', taskId: 't_charge', dueDate: day(-1), status: ScheduleStatus.skipped),
    ];
  }
}
