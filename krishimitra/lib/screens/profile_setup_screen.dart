import 'package:flutter/material.dart';
import '../models/user_details.dart';
import '../services/user_service.dart';

class ProfileSetupScreen extends StatefulWidget {
  @override
  _ProfileSetupScreenState createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _cityController = TextEditingController();

  String? _selectedCrop;
  String? _selectedState;
  String? _selectedDistrict;
  bool _isLoading = false;

  final List<String> states = [
  'ఆంధ్ర ప్రదేశ్/Andhra Pradesh',
    'తెలంగాణ/Telangana',
  ];






  List<String> apDistricts = [
    'Srikakulam',
    'Vizianagaram',
    'Parvathipuram Manyam',
    'Alluri Sitharama Raju',
    'Visakhapatnam',
    'Anakapalli',
    'Kakinada',
    'Dr. B.R. Ambedkar Konaseema',
    'East Godavari',
    'West Godavari',
    'Eluru',
    'Krishna',
    'NTR District',
    'Guntur',
    'Palnadu',
    'Bapatla',
    'Prakasam',
    'Sri Potti Sriramulu Nellore',
    'Kurnool',
    'Nandyal',
    'Anantapur',
    'Sri Sathya Sai',
    'YSR Kadapa',
    'Annamayya',
    'Chittoor',
    'Sri Balaji District',
  ];





  List<String> telanganaDistricts = [
    'Adilabad',
    'Komaram Bheem Asifabad',
    'Mancherial',
    'Nirmal',
    'Nizamabad',
    'Jagtial',
    'Peddapalli',
    'Karimnagar',
    'Rajanna Sircilla',
    'Jayashankar Bhupalpally',
    'Mulugu',
    'Bhadradri Kothagudem',
    'Khammam',
    'Mahabubabad',
    'Warangal (Hanamkonda)',
    'Warangal (Warangal)',
    'Jangaon',
    'Siddipet',
    'Mahabubnagar',
    'Nagarkurnool',
    'Wanaparthy',
    'Jogulamba Gadwal',
    'Kamareddy',
    'Medak',
    'Sangareddy',
    'Vikarabad',
    'Rangareddy',
    'Hyderabad',
    'Medchal-Malkajgiri',
    'Yadadri Bhuvanagiri',
    'Suryapet',
    'Nalgonda',
    'Narayanpet',
  ];

  List<String> andhraCrops = [
    'Ajwan',
    'Arhar (Tur/Red Gram)(Whole)',
    'Bajra (Pearl Millet/Cumbu)',
    'Banana',
    'Beetroot',
    'Bengal Gram Dal (Chana Dal)',
    'Bengal Gram (Gram)(Whole)',
    'Black Gram (Urd Beans)(Whole)',
    'Brinjal',
    'Cabbage',
    'Cashewnuts',
    'Castor Seed',
    'Cauliflower',
    'Cluster Beans',
    'Cotton',
    'Dry Chillies',
    'Foxtail Millet (Navane)',
    'Green Chilli',
    'Green Gram Dal (Moong Dal)',
    'Ground Nut Oil',
    'Groundnut',
    'Gur (Jaggery)',
    'Kulthi (Horse Gram)',
    'Lemon',
    'Maize',
    'Onion',
    'Paddy (Dhan)(Common)',
    'Potato',
    'Ridgeguard (Tori)',
    'She Goat',
    'Sheep',
    'Soyabean',
    'Sunflower',
    'Tomato',
    'Turmeric',
    'Wood',
  ];

  List<String> telanganaCrops = [
    'Amaranthus',
    'Amla (Nelli Kai)',
    'Apple',
    'Arhar (Tur/Red Gram)(Whole)',
    'Arhar Dal (Tur Dal)',
    'Bajra (Pearl Millet/Cumbu)',
    'Banana',
    'Banana - Green',
    'Beans',
    'Beetroot',
    'Bengal Gram (Gram)(Whole)',
    'Ber (Zizyphus/Borehannu)',
    'Bhindi (Ladies Finger)',
    'Bitter Gourd',
    'Black Gram (Urd Beans)(Whole)',
    'Black Gram Dal (Urd Dal)',
    'Bottle Gourd',
    'Brinjal',
    'Bull',
    'Cabbage',
    'Calf',
    'Capsicum',
    'Carnation',
    'Carrot',
    'Castor Seed',
    'Cauliflower',
    'Cherry',
    'Chikoos (Sapota)',
    'Chili Red',
    'Chow Chow',
    'Cluster Beans',
    'Colacasia',
    'Coriander Seed',
    'Cotton',
    'Cow',
    'Cowpea (Lobia/Karamani)',
    'Cucumber (Kheera)',
    'Custard Apple (Sharifa)',
    'Drumstick',
    'Dry Chillies',
    'Field Pea',
    'French Beans (Frasbean)',
    'Garlic',
    'Ginger (Dry)',
    'Gladiolus Cut Flower',
    'Grapes',
    'Green Chilli',
    'Green Gram (Moong)(Whole)',
    'Ground Nut Seed',
    'Groundnut',
    'Groundnut Pods (Raw)',
    'Guava',
    'Gur (Jaggery)',
    'He Buffalo',
    'Indian Beans (Seam)',
    'Jack Fruit',
    'Jarbara',
    'Jasmine',
    'Jowar (Sorghum)',
    'Karbuja (Musk Melon)',
    'Kinnow',
    'Knool Khol',
    'Leafy Vegetable',
    'Lilly',
    'Litchi',
    'Little Gourd (Kundru)',
    'Maize',
    'Mango',
    'Marigold (Calcutta)',
    'Marigold (Loose)',
    'Mousambi (Sweet Lime)',
    'Onion',
    'Onion Green',
    'Orange',
    'Ox',
    'Paddy (Dhan)(Basmati)',
    'Paddy (Dhan)(Common)',
    'Papaya',
    'Pineapple',
    'Plum',
    'Pomegranate',
    'Potato',
    'Pumpkin',
    'Raddish',
    'Ragi (Finger Millet)',
    'Ridgeguard (Tori)',
    'Rose (Local)',
    'Safflower',
    'Sesamum (Sesame, Gingelly, Til)',
    'She Buffalo',
    'Snakeguard',
    'Soyabean',
    'Sunflower',
    'Sweet Potato',
    'Tamarind Fruit',
    'Tamarind Seed',
    'Tender Coconut',
    'Tomato',
    'Turmeric',
    'Water Melon',
    'Wheat',
    'White Pumpkin',
    'Wood',
    'Yam',
    'Yam (Ratalu)',
  ];


  UserDetails? _previousUserDetails;

  @override
  void initState() {
    super.initState();
    _loadPreviousUserDetails();
  }

  Future<void> _loadPreviousUserDetails() async {
    // Fetch user details from UserPreferences
    UserDetails? userDetails = await UserPreferences.getUserDetails(); // Make sure this method exists
    if (userDetails != null) {
      setState(() {
        _previousUserDetails = userDetails;
        _nameController.text = userDetails.name;
        _selectedState = userDetails.state;
        _cityController.text = userDetails.city;
        _selectedDistrict =userDetails.district;
        _selectedCrop = userDetails.crop; // Assuming crop is stored in UserDetails
      });
    }
  }


  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final userDetails = UserDetails(
        name: _nameController.text.trim(),
        state: _selectedState ?? '',
        city: _cityController.text.trim(),
        district:_selectedDistrict ?? '',
        crop: _selectedCrop ?? '',

        email: '', // Add email if required
      );

      await UserPreferences.saveUserDetails(userDetails);

      // Navigate to the next screen, passing userDetails
      Navigator.pushReplacementNamed(
        context,
        '/home',
        arguments: userDetails,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> cropsToDisplay = []; // To hold the crops based on selected state

    if (_selectedState == 'ఆంధ్ర ప్రదేశ్/Andhra Pradesh') {
      cropsToDisplay = andhraCrops;

    } else if (_selectedState == 'తెలంగాణ/Telangana') {
      cropsToDisplay = telanganaCrops;

    }



     // To hold the districts  based on selected state
    List<String> districtsToDisplay = [];
    if (_selectedState == 'ఆంధ్ర ప్రదేశ్/Andhra Pradesh') {
      districtsToDisplay=apDistricts;
    } else if (_selectedState == 'తెలంగాణ/Telangana') {
      districtsToDisplay=telanganaDistricts;
    }








    return WillPopScope(
      onWillPop: () async => false, // Prevents back navigation
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'రైతు వివరాలు',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,              // Adjust font size as needed
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.green,
          elevation: 4,                  // Adds shadow under AppBar
          leading: ModalRoute.of(context)?.isFirst ?? true
              ? null                     // No back button on first screen
              : IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,  // Back button color
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),

        body: Container(
          decoration: BoxDecoration(
            // image: DecorationImage(
            //   image: AssetImage('assets/images/farm_background.jpg'),
            //   fit: BoxFit.cover,
            //   colorFilter: ColorFilter.mode(
            //     Colors.white.withOpacity(0.9),
            //     BlendMode.lighten,
            //   ),
            // ),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'స్వాగతం / Welcome',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(height: 20),

                      // Name Field
                      _buildTextField(
                        controller: _nameController,
                        label: 'పేరు / Name',
                        icon: Icons.person,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'దయచేసి మీ పేరు నమోదు చేయండి / Please enter your name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),

                      // State Dropdown
                      DropdownButtonFormField<String>(
                        value: _selectedState,
                        items: states.map((String state) {
                          return DropdownMenuItem<String>(
                            value: state,
                            child: Text(state),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: 'రాష్ట్రం / State',
                          prefixIcon: Icon(Icons.map, color: Colors.green),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        onChanged: (value) {
                          setState(() {
                            _selectedState = value; // Set selected state
                            _selectedCrop = null; // Reset crop selection
                            _selectedDistrict=null;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a state';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),



                        // Distirct drop down menu
                      DropdownButtonFormField<String>(
                        value: _selectedDistrict,
                        items: districtsToDisplay.map((String district) {
                          return DropdownMenuItem<String>(
                            value: district,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width * 0.5, // Set width to 80% of screen width
                              ),
                              child: SingleChildScrollView( // Allow horizontal scrolling
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  district,
                                  style: TextStyle(fontSize: 16),
                                  overflow: TextOverflow.ellipsis, // Truncate if necessary
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: 'జిల్లా / district',
                          prefixIcon: Icon(Icons.agriculture, color: Colors.green),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        onChanged: (value) {
                          setState(() {
                            _selectedDistrict = value; // Update the selected crop in your state
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a valid district';
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 24),




                      // City Field
                      _buildTextField(
                        controller: _cityController,
                        label: 'గ్రామం/మండలం / Village/Mandal',
                        icon: Icons.location_city,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'దయచేసి మీ గ్రామం పేరు నమోదు చేయండి / Please enter your village';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),

                      // Crop Dropdown
                    DropdownButtonFormField<String>(
                      value: _selectedCrop,
                      items: cropsToDisplay.map((String crop) {
                        return DropdownMenuItem<String>(
                          value: crop,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.5, // Set width to 80% of screen width
                            ),
                            child: SingleChildScrollView( // Allow horizontal scrolling
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                crop,
                                style: TextStyle(fontSize: 16),
                                overflow: TextOverflow.ellipsis, // Truncate if necessary
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: 'పంట / Crop',
                        prefixIcon: Icon(Icons.agriculture, color: Colors.green),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _selectedCrop = value; // Update the selected crop in your state
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a crop';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 24),

                      // Save Button
                      _isLoading
                          ? CircularProgressIndicator()
                          : ElevatedButton.icon(
                        onPressed: _saveProfile,
                        icon: Icon(Icons.save),
                        label: Text(
                          'కొనసాగించండి / Continue',
                          style: TextStyle(fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                          minimumSize: Size(double.infinity, 50),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.green),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: validator,
    );
  }
}
