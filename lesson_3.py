class Car:
    counter = 0
    __total_fuel = 1000

    @staticmethod
    def get_fuel_type():
        return 'AI 95'

    @classmethod
    def get_fuel(cls):
        return cls.__total_fuel

    @classmethod
    def fill_fuel(cls, amount):
        cls.__total_fuel += amount

    # constructor                   #paramethers
    def __init__(self, theModel, theYear, theColor, wheels_number=4):
        # attributes/fields
        self.__model = theModel
        self.__year = theYear
        self.__color = theColor
        self.__wheels_number = wheels_number
        self.__was_produced()

    def __was_produced(self):
        print(f'Car {self.__model} was produced')
        Car.counter += 1
        Car.__total_fuel -= 50

    @property
    def model(self):
        return self.__model

    @property
    def year(self):
        return self.__year

    @property
    def color(self):
        return self.__color

    @color.setter
    def color(self, value):
        self.__color = value

    def get_wheels_number(self):
        return self.__wheels_number

    def set_wheels_number(self, new_wheels_number):
        if type(new_wheels_number) != int or new_wheels_number < 0:
            print('Wrong type or value for attribute wheels_number')
        else:
            self.__wheels_number = new_wheels_number

    # method
    def drive(self, city):
        print(f'Car {self.__model} is driving to {city}')

    def calculate_age(self):
        return 2023 - self.__year


print(f'Fabric CAR produced {Car.counter} cars.')
print(f'At fabric CAR {Car.get_fuel()} ({Car.get_fuel_type()}) '
      f'litters of fuel left.')

bmw_car = Car('BMW X7', 2022, 'red')
print(bmw_car)
print(f'MODEL: {bmw_car.model} YEAR: {bmw_car.year} COLOR: {bmw_car.color} '
      f'WHEELS NUMBER: {bmw_car.get_wheels_number()} AGE: {bmw_car.calculate_age()}')

honda_car = Car(theYear=2009, theModel='Honda Civic',
                wheels_number=5, theColor='green')
print(f'MODEL: {honda_car.model} YEAR: {honda_car.year} '
      f'COLOR: {honda_car.color} WHEELS NUMBER: {honda_car.get_wheels_number()} '
      f'AGE: {honda_car.calculate_age()}')

bmw_car.drive('Bishkek')
honda_car.drive('Osh')
honda_car.drive('Batken')

honda_car.color = 'yellow'
print(f'MODEL: {honda_car.model} YEAR: {honda_car.year} '
      f'NEW COLOR: {honda_car.color} WHEELS NUMBER: {honda_car.get_wheels_number()} '
      f'AGE: {honda_car.calculate_age()}')

# bmw_car.year = 'two thousand and twenty one'
bmw_car.set_wheels_number(6)
print(f'MODEL: {bmw_car.model} YEAR: {bmw_car.year} COLOR: {bmw_car.color} '
      f'WHEELS NUMBER: {bmw_car.get_wheels_number()} '
      f'AGE: {bmw_car.calculate_age()}')
Car.counter = 19

print(f'Fabric CAR produced {Car.counter} cars.')
# Car.total_fuel -= 100
Car.fill_fuel(500)
print(f'At fabric CAR {Car.get_fuel()} ({Car.get_fuel_type()}) litters of fuel left.')
