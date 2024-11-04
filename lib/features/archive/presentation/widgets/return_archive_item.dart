import 'package:flutter/material.dart';
import 'text_badge.dart';

class ReturnArchiveItem extends StatelessWidget {
  final String borrowNumber;
  final String archiveNumber;
  final String borrowDate;
  final String description;

  const ReturnArchiveItem({
    super.key,
    this.borrowNumber = 'PJM-2024-001',
    this.archiveNumber = 'ARS/KLH/2024/001',
    this.borrowDate = '20 Maret 2024',
    this.description = 'Arsip Surat Tanah',
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ReturnArchiveDetail(
              borrowNumber: borrowNumber,
              archiveNumber: archiveNumber,
              borrowDate: borrowDate,
              description: description,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        margin: const EdgeInsets.symmetric(horizontal: 12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    borrowNumber,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextBadge(
                    text: 'Dikembalikan',
                    color: Colors.green,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildInfoRow(
                Icons.folder_outlined,
                'Nomor Arsip',
                archiveNumber,
              ),
              const SizedBox(height: 8),
              _buildInfoRow(
                Icons.calendar_today_outlined,
                'Tanggal Pinjam',
                borrowDate,
              ),
              const SizedBox(height: 8),
              _buildInfoRow(
                Icons.description_outlined,
                'Keterangan',
                description,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReturnArchiveDetail(
                            borrowNumber: borrowNumber,
                            archiveNumber: archiveNumber,
                            borrowDate: borrowDate,
                            description: description,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('Lihat Detail'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.blue,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Expanded(
          child: Row(
            children: [
              Text(
                '$label: ',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
              Expanded(
                child: Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ReturnArchiveDetail extends StatelessWidget {
  final String borrowNumber;
  final String archiveNumber;
  final String borrowDate;
  final String description;

  const ReturnArchiveDetail({
    super.key,
    required this.borrowNumber,
    required this.archiveNumber,
    required this.borrowDate,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pengembalian'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Icon(
                    Icons.assignment_return_rounded,
                    size: 60,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    borrowNumber,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const TextBadge(
                    text: 'Dikembalikan',
                    color: Colors.green,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailSection(
                    'Informasi Arsip',
                    [
                      _buildDetailItem(
                        'Nomor Arsip',
                        archiveNumber,
                        Icons.folder_outlined,
                      ),
                      _buildDetailItem(
                        'Keterangan',
                        description,
                        Icons.description_outlined,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildDetailSection(
                    'Informasi Peminjaman',
                    [
                      _buildDetailItem(
                        'Tanggal Pinjam',
                        borrowDate,
                        Icons.calendar_today_outlined,
                      ),
                      _buildDetailItem(
                        'Tanggal Kembali',
                        '25 Maret 2024',
                        Icons.event,
                      ),
                      _buildDetailItem(
                        'Durasi Peminjaman',
                        '5 hari',
                        Icons.timer_outlined,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildDetailSection(
                    'Informasi Peminjam',
                    [
                      _buildDetailItem(
                        'Nama Peminjam',
                        'John Doe',
                        Icons.person_outline,
                      ),
                      _buildDetailItem(
                        'Departemen',
                        'Bagian Umum',
                        Icons.business_outlined,
                      ),
                      _buildDetailItem(
                        'Keperluan',
                        'Verifikasi data kepemilikan tanah',
                        Icons.note_outlined,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailItem(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 24, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:archive_management_system/features/archive/presentation/widgets/text_badge.dart';
// import 'package:flutter/material.dart';

// class ReturnArchiveItem extends StatelessWidget {
//   const ReturnArchiveItem({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         // Navigate to detail page
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => ReturnArchiveDetailPage()),
//         );
//       },
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 8),
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.3),
//               blurRadius: 5,
//               offset: Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Nomor Pinjam',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text('Nomor Arsip/Kelurahan',
//                     style: TextStyle(color: Colors.grey[600])),
//                 const SizedBox(height: 4),
//                 Text('Tanggal Pinjam',
//                     style: TextStyle(color: Colors.grey[600])),
//                 const SizedBox(height: 4),
//                 Text('Keterangan', style: TextStyle(color: Colors.grey[600])),
//               ],
//             ),
//             TextBadge(text: 'Dikembalikan', color: Colors.green),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ReturnArchiveDetailPage extends StatelessWidget {
//   const ReturnArchiveDetailPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Detail Arsip'),
//         backgroundColor: Colors.teal,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Card(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           elevation: 4,
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 ListTile(
//                   leading: Icon(Icons.bookmark, color: Colors.teal),
//                   title: Text(
//                     'Nomor Pinjam',
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   subtitle: Text('123456'),
//                 ),
//                 Divider(),
//                 ListTile(
//                   leading: Icon(Icons.location_city, color: Colors.teal),
//                   title: Text(
//                     'Nomor Arsip/Kelurahan',
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   subtitle: Text('Pontianak Barat / Sungai'),
//                 ),
//                 Divider(),
//                 ListTile(
//                   leading: Icon(Icons.calendar_today, color: Colors.teal),
//                   title: Text(
//                     'Tanggal Pinjam',
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   subtitle: Text('2024-11-01'),
//                 ),
//                 Divider(),
//                 ListTile(
//                   leading: Icon(Icons.info_outline, color: Colors.teal),
//                   title: Text(
//                     'Keterangan',
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   subtitle: Text('Arsip sudah dikembalikan dalam kondisi baik'),
//                 ),
//                 Divider(),
//                 Center(
//                   child: ElevatedButton.icon(
//                     onPressed: () {
//                       // Implementasikan tindakan kembali atau konfirmasi lainnya
//                     },
//                     icon: Icon(Icons.check_circle, color: Colors.white),
//                     label: Text('Konfirmasi Pengembalian'),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.teal,
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
