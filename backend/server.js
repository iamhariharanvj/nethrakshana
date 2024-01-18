const express = require('express');
const cors = require("cors");
const bodyParser = require('body-parser');

const app = express();
const PORT = process.env.PORT || 5000;
app.use(cors());
app.use(bodyParser.json());

const users = [
    {
      UIN: '123',
      password: 'password',
      mobile: '9360994497',
      patientName: 'HariHaran',
      age: 20,
      gender: 'Male',
      address: '123 Main St',
      city: 'Madurai',
    },
  ];
const appointments = [];

// List of available locations
const locations = [
  {
    name: 'Aravind Eye Hospital - Madurai',
    address: '1, Anna Nagar, Madurai - 625 020, Tamil Nadu, India',
    phone: '(0452) 435 6105',
    email: 'patientfeedback@aravind.org',
    mapUrl: 'https://maps.google.com/?q=1,Anna+Nagar,Madurai',
  },
  {
    name: 'Aravind Eye Hospital - City Centre',
    address: '135, Palace Road, Madurai - 625 001, Tamil Nadu, India',
    phone: '(0452) 4231002',
    email: 'patientcare@aravind.org',
    mapUrl: 'https://maps.google.com/?q=135,Palace+Road,Madurai',
  },
  {
    name: 'Aravind Eye Hospital - Tirumangalam',
    address: 'Behind Bus Stand, Chinnamani Street, Thirumangalam - 625 706, Tamil Nadu, India',
    phone: '(04549) 280230',
    email: 'cc_thirumangalam@aravind.org',
    mapUrl: 'https://maps.google.com/?q=Thirumangalam',
  },
  {
    name: 'Aravind Eye Hospital - Melur',
    address: '420F, Alagarkovil Road, Opp. Baskaran Hospital, Melur - 625 106, Tamil Nadu, India',
    phone: '(0452) 4210595',
    email: 'cc_melur@aravind.org',
    mapUrl: 'https://maps.google.com/?q=Melur',
  },
];

// Function to generate a unique UIN
const generateUniqueUIN = () => {
  let newUIN;
  do {
    newUIN = Math.floor(Math.random() * 1000).toString();
  } while (users.some(user => user.UIN === newUIN));
  return newUIN;
};

// Function to generate a unique appointment ID
const generateUniqueAppointmentID = () => {
  return Math.floor(Math.random() * 1000000).toString();
};

app.get("/", (req, res) => {
  res.send("Server is up and running!");
});

app.get('/user-details/:uin', (req, res) => {
  const uinParam = req.params.uin;
  const user = users.find(user => user.UIN === uinParam);

  if (!user) {
    return res.status(404).json({ message: 'User not found' });
  }

  res.status(200).json(user);
});

app.get('/locations', (req, res) => {
    console.log("Locations sent successfully")
  res.status(200).json(locations);
});

app.post('/register', (req, res) => {
  const { password, mobile, patientName, age, gender, address, city } = req.body;

  if (users.find(user => user.mobile === mobile)) {
    return res.status(400).json({ message: 'Mobile number already exists' });
  }

  const UIN = generateUniqueUIN();
  users.push({ UIN, password, mobile, patientName, age, gender, address, city });

  res.status(201).json({ message: 'User registered successfully', UIN });
});

app.post('/login', (req, res) => {
  const { UIN, password } = req.body;

  const user = users.find(user => user.UIN === UIN);

  if (!user || user.password !== password) {
    console.log("Invalid Cred");
    return res.status(401).json({ message: 'Invalid credentials' });
  }

  console.log("Login Success");
  res.status(200).json({ message: 'Login successful' });
});

app.post('/forgot-password', (req, res) => {
  const { mobile } = req.body;
  const user = users.find(user => user.mobile === mobile);

  if (!user) {
    return res.status(404).json({ message: 'User not found' });
  }

  res.json({ UIN: user.UIN });
});

app.post('/reset-password', (req, res) => {
  res.json({ message: 'Password reset successful' });
});

// New route to book an appointment
app.post('/book-appointment', (req, res) => {
  const { UIN, date, location } = req.body;
  const selectedLocation = locations.find(loc => loc.name === location);
  if (!selectedLocation) {
    
    return res.status(400).json({ message: 'Invalid location selected' });
  }

  const user = users.find(user => user.UIN === UIN);
  if (!user) {
    return res.status(404).json({ message: 'User not found' });
  }
  const appointmentId = generateUniqueAppointmentID();
  appointments.push({ appointmentId, UIN, date, location });

  res.status(201).json({ message: 'Appointment booked successfully', appointmentId });
});

// New route to retrieve appointments for a specific user
app.get('/user-appointments/:uin', (req, res) => {
  const uinParam = req.params.uin;
  const userAppointments = appointments.filter(appointment => appointment.UIN === uinParam);

  res.status(200).json(userAppointments);
});

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
