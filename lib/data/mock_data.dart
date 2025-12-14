import 'package:trizion_car_rental/models/car.dart';

final List<Car> mockCars = [
  Car(
    id: 'c1',
    name: 'Hyundai i20',
    imageUrl:
    'https://images.unsplash.com/photo-1619767886558-efdc259cde1b?auto=format&fit=crop&w=1200&q=80',
    category: 'Hatchback',
    seats: 5,
    pricePerDay: 2000,
    available: true,
    description: 'Comfortable city car with great mileage.',
  ),
  Car(
    id: 'c2',
    name: 'Maruti Dzire',
    imageUrl:
    'https://images.unsplash.com/photo-1603386329225-868f9b1d06b9?auto=format&fit=crop&w=1200&q=80',
    category: 'Sedan',
    seats: 5,
    pricePerDay: 2500,
    available: true,
    description: 'Reliable sedan good for family trips.',
  ),
  Car(
    id: 'c3',
    name: 'Hyundai Creta',
    imageUrl:
    'https://images.unsplash.com/photo-1617531653332-bd46c24f2068?auto=format&fit=crop&w=1200&q=80',
    category: 'SUV',
    seats: 5,
    pricePerDay: 3500,
    available: true,
    description: 'Premium SUV with modern features.',
  ),
  Car(
    id: 'c4',
    name: 'Toyota Fortuner',
    imageUrl:
    'https://images.unsplash.com/photo-1601362840469-51e4d8d58785?auto=format&fit=crop&w=1200&q=80',
    category: 'SUV',
    seats: 7,
    pricePerDay: 5500,
    available: false,
    description: 'Luxury SUV with commanding presence.',
  ),
  Car(
    id: 'c5',
    name: 'Honda City',
    imageUrl:
    'https://images.unsplash.com/photo-1626072557464-904cfae5a3a1?auto=format&fit=crop&w=1200&q=80',
    category: 'Sedan',
    seats: 5,
    pricePerDay: 2800,
    available: true,
    description: 'Smooth sedan with premium comfort.',
  ),
];
