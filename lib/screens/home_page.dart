import 'package:flutter/material.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _numberController = TextEditingController();
  int _listItemCount = 0;
  bool _isListVisible = false;
  String _selectedRadio = 'Option 1';
  bool _isChecked1 = false;
  bool _isChecked2 = false;

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  void _showModalDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          key: const Key('modalDialog'),
          title: const Text('Modal Title', key: Key('modalTitle')),
          content: const Text(
            'This is a modal description',
            key: Key('modalDescription'),
          ),
          actions: [
            ElevatedButton(
              key: const Key('modalOkButton'),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK', key: Key('modalOkButtonText')),
            ),
          ],
        );
      },
    );
  }

  void _showList() {
    final number = int.tryParse(_numberController.text) ?? 0;
    setState(() {
      _listItemCount = number;
      _isListVisible = true;
    });
  }

  void _hideList() {
    setState(() {
      _isListVisible = false;
      _listItemCount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home', key: Key('homePageAppBarTitle')),
        key: const Key('homePageAppBar'),
        actions: [
          IconButton(
            key: const Key('logoutButton'),
            icon: const Icon(Icons.logout, key: Key('logoutIcon')),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        key: const Key('homePageScrollView'),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          key: const Key('homePageMainColumn'),
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 32),
            const Text(
              'Welcome!',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              key: Key('homePageTitle'),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'You have successfully logged in.',
              style: TextStyle(fontSize: 16),
              key: Key('homePageSubtitle'),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              key: const Key('showModalButton'),
              onPressed: _showModalDialog,
              child: const Text(
                'Show modal screen',
                key: Key('showModalButtonText'),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              key: const Key('numberInputRow'),
              children: [
                Expanded(
                  child: TextField(
                    key: const Key('numberInput'),
                    controller: _numberController,
                    decoration: InputDecoration(
                      labelText: 'Enter number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  key: const Key('showListButton'),
                  onPressed: _showList,
                  child: const Text(
                    'Show list',
                    key: Key('showListButtonText'),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  key: const Key('hideListButton'),
                  onPressed: _hideList,
                  child: const Text(
                    'Hide list',
                    key: Key('hideListButtonText'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            if (_isListVisible)
              Column(
                key: const Key('dynamicListContainer'),
                children: [
                  ...List.generate(
                    _listItemCount,
                    (index) => Card(
                      key: Key('dynamicCard_${index + 1}'),
                      child: Padding(
                        key: Key('dynamicCardPadding_${index + 1}'),
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Element from list of cards ${index + 1}',
                          key: Key('dynamicCardText_${index + 1}'),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            Container(
              key: const Key('radioButtonsContainer'),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Radio Buttons:', key: Key('radioButtonsLabel')),
                  RadioListTile<String>(
                    key: const Key('radio1'),
                    title: const Text('Option 1', key: Key('radio1Label')),
                    value: 'Option 1',
                    groupValue: _selectedRadio,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedRadio = value!;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    key: const Key('radio2'),
                    title: const Text('Option 2', key: Key('radio2Label')),
                    value: 'Option 2',
                    groupValue: _selectedRadio,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedRadio = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              key: const Key('checkboxesContainer'),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Checkboxes:', key: Key('checkboxesLabel')),
                  CheckboxListTile(
                    key: const Key('checkbox1'),
                    title: const Text('Checkbox 1', key: Key('checkbox1Label')),
                    value: _isChecked1,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked1 = value!;
                      });
                    },
                  ),
                  CheckboxListTile(
                    key: const Key('checkbox2'),
                    title: const Text('Checkbox 2', key: Key('checkbox2Label')),
                    value: _isChecked2,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked2 = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
