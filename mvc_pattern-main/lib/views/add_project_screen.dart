import 'package:flutter/material.dart';
import '../controllers/project_controller.dart';

class AddProjectScreen extends StatefulWidget {
  const AddProjectScreen({Key? key}) : super(key: key);

  @override
  State<AddProjectScreen> createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  final ProjectController _projectController = ProjectController();

  String _group = 'Work';
  String _name = 'Grocery Shopping App';
  String _description = 'This application is designed for super shops. By using this application they can enlist all their products in one place and can deliver. Customers will get a one-stop solution for their daily shopping.';
  DateTime _startDate = DateTime(2022, 5, 1);
  DateTime _endDate = DateTime(2022, 5, 30);
// Add controller
  late TextEditingController _descriptionController;
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController(text: _description);
    _nameController = TextEditingController(text: _name);
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _nameController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F5FD),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: const Text('Add Project',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _label('Task Group'),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: _showGroupPicker,
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 6)
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      const Icon(Icons.work_outline, color: Colors.pink),
                      const SizedBox(width: 10),
                      Text(_group,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500)),
                    ]),
                    const Icon(Icons.keyboard_arrow_down),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            _label('Project Name'),
            const SizedBox(height: 8),
            TextField(
              onChanged: (v) => _name = v,
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Enter project name',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 20),

            _label('Description'),
            const SizedBox(height: 8),
            TextField(
              onChanged: (v) => _description = v,
              controller: _descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Enter description',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none),
              ),
            ),

            const SizedBox(height: 20),

            _label('Start Date'),
            const SizedBox(height: 8),
            _buildDateField('Start Date', _startDate,
                    () => _pickDate(isStart: true)),
            const SizedBox(height: 20),

            _label('End Date'),
            const SizedBox(height: 8),
            _buildDateField(
                'End Date', _endDate, () => _pickDate(isStart: false)),

            const SizedBox(height: 24),

            // Logo section
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.orange,
                    child: Icon(Icons.store, color: Colors.white, size: 30),
                  ),
                  const SizedBox(height: 8),
                  const Text('Grocery Shop',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Change Logo',
                        style: TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.w600)),
                  )
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Add Project Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: () {
                  _projectController.addProject(
                    group: _group,
                    name: _name,
                    description: _description,
                    startDate: _startDate,
                    endDate: _endDate,
                  );

                  // Simple confirmation
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Project added')),
                  );
                  Navigator.of(context).pop();
                },
                child: const Text('Add Project',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700)),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _label(String t) =>
      Text(t, style: TextStyle(color: Colors.grey[700], fontSize: 13));

  Widget _buildDateField(
      String label, DateTime value, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
        const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 6)
            ]),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_formatDate(value),
                  style: const TextStyle(fontSize: 15)),
              const Icon(Icons.calendar_today, size: 18)
            ]),
      ),
    );
  }

  String _formatDate(DateTime d) {
    final monthNames = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    return '${d.day} ${monthNames[d.month - 1]}, ${d.year}';
  }

  Future<void> _pickDate({required bool isStart}) async {
    final initial = isStart ? _startDate : _endDate;
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  void _showGroupPicker() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Work'),
            onTap: () => setState(() {
              _group = 'Work';
              Navigator.of(ctx).pop();
            }),
          ),
          ListTile(
            title: const Text('Personal'),
            onTap: () => setState(() {
              _group = 'Personal';
              Navigator.of(ctx).pop();
            }),
          ),
          ListTile(
            title: const Text('Shopping'),
            onTap: () => setState(() {
              _group = 'Shopping';
              Navigator.of(ctx).pop();
            }),
          ),
        ],
      ),
    );
  }
}
