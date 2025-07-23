import 'package:flutter/material.dart';
import 'package:queerie_test/core/localization/generated/strings.dart';

class MovieFilterModal extends StatefulWidget {
  final String? initialType;
  final String? initialYear;
  final void Function(String? type, String? year) onApply;
  final VoidCallback onReset;

  const MovieFilterModal({
    super.key,
    this.initialType,
    this.initialYear,
    required this.onApply,
    required this.onReset,
  });

  @override
  State<MovieFilterModal> createState() => _MovieFilterModalState();
}

class _MovieFilterModalState extends State<MovieFilterModal> {
  String? tempType;
  String? tempYear;
  late TextEditingController yearController;

  @override
  void initState() {
    super.initState();
    tempType = widget.initialType ?? '';
    tempYear = widget.initialYear;
    yearController = TextEditingController(text: tempYear);
  }

  @override
  void dispose() {
    yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.55,
      maxChildSize: 0.8,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).dialogBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 12,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Text(Strings.of(context)!.filter, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Text(
                  Strings.of(context)!.type,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: tempType ?? '',
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    isDense: true,
                  ),
                  items: [
                    DropdownMenuItem(
                      value: '',
                      child: Text(
                        Strings.of(context)!.clear,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'movie',
                      child: Text(
                        Strings.of(context)!.movie,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'series',
                      child: Text(
                        Strings.of(context)!.series,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'episode',
                      child: Text(
                        Strings.of(context)!.episode,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                  onChanged: (value) => setState(() => tempType = value),
                ),
                const SizedBox(height: 20),
                const Divider(height: 1),
                const SizedBox(height: 20),
                Text(Strings.of(context)!.year, style: const TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () async {
                    final now = DateTime.now();
                    int initialYear = tempYear != null && tempYear!.isNotEmpty
                        ? int.tryParse(tempYear!) ?? now.year
                        : now.year;
                    int? pickedYear;
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(Strings.of(context)!.year),
                          content: SizedBox(
                            width: 300,
                            height: 300,
                            child: YearPicker(
                              firstDate: DateTime(1900),
                              lastDate: DateTime(now.year + 1),
                              initialDate: DateTime(initialYear),
                              selectedDate: DateTime(initialYear),
                              onChanged: (date) {
                                pickedYear = date.year;
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        );
                      },
                    );
                    if (pickedYear != null) {
                      setState(() {
                        tempYear = pickedYear.toString();
                      });
                    }
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).dividerColor),
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).inputDecorationTheme.fillColor ?? Theme.of(context).colorScheme.surface,
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today, size: 20, color: Theme.of(context).iconTheme.color),
                        const SizedBox(width: 12),
                        Text(
                          tempYear?.isNotEmpty == true ? tempYear! : Strings.of(context)!.year,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: tempYear?.isNotEmpty == true
                                ? Theme.of(context).textTheme.bodyMedium?.color
                                : Theme.of(context).hintColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          tempType = null;
                          tempYear = null;
                        });
                        widget.onReset();
                        Navigator.pop(context);
                      },
                      child: Text(Strings.of(context)!.reset),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () {
                        widget.onApply(tempType, (tempYear != null && tempYear!.isNotEmpty) ? tempYear : null);
                        Navigator.pop(context);
                      },
                      child: Text(Strings.of(context)!.apply, style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
} 