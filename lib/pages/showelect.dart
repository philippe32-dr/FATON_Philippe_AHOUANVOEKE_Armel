import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tp_election/pages/candidates.dart';
import 'addelected.dart';

class ShowElectPage extends StatefulWidget {
  const ShowElectPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ShowElectPageState createState() => _ShowElectPageState();
}

class _ShowElectPageState extends State<ShowElectPage> {
  final List<Candidate> _candidates = [];

  void _addCandidate(Candidate candidate) {
    setState(() {
      _candidates.add(candidate);
    });
  }

  String _formatBio(String bio) {
    if (bio.length > 500) {
      return '${bio.substring(0, 500)}... \nRead more';
    }
    return bio;
  }

  void _navigateToCandidateDetails(Candidate candidate) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text('Candidate Details')),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    candidate.party,
                    style: const TextStyle(color: Colors.green, fontSize: 20),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    '${candidate.name} ${candidate.surname}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ),
                const SizedBox(height: 8),
                const Text('Candidat', style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 16),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8),
                    image: candidate.imagePath != null
                        ? DecorationImage(
                            image: FileImage(File(candidate.imagePath!)),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                ),
                const SizedBox(height: 16),
                Text(candidate.bio),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello Samiat'),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            padding: const EdgeInsets.only(bottom: 8.0),
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        color: Colors.grey[300],
        child: Column(
          children: [
            // Padding for horizontal navigation bar
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: SizedBox(),
            ),
            // Horizontal navigation bar
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavigationButton('Presidential'),
                  const VerticalDivider(
                    width: 10,
                    thickness: 2,
                    color: Colors.grey,
                  ),
                  _buildNavigationButton('Governship'),
                  const VerticalDivider(
                    width: 10,
                    thickness: 2,
                    color: Colors.grey,
                  ),
                  _buildNavigationButton('LGDA'),
                ],
              ),
            ),
            // Candidates header
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Candidates'),
                  Text('${_candidates.length} candidats'),
                ],
              ),
            ),
            // Candidates list
            Expanded(
              child: ListView.builder(
                itemCount: _candidates.length,
                itemBuilder: (context, index) {
                  final candidate = _candidates[index];
                  return Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      leading: candidate.imagePath != null
                          ? CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  FileImage(File(candidate.imagePath!)),
                            )
                          : CircleAvatar(
                              radius: 30,
                              child: Icon(
                                Icons.person,
                                color: Colors.grey[300],
                              ),
                            ),
                      title: Text('${candidate.name} ${candidate.surname}'),
                      subtitle: Text(_formatBio(candidate.bio)),
                      onTap: () {
                        _navigateToCandidateDetails(candidate);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddElectPage(
                addCandidate: (candidate) => _addCandidate(candidate),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.how_to_vote),
            label: 'Vote',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButton(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onPressed: () {},
        child: Text(title),
      ),
    );
  }
}
