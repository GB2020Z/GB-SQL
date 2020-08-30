# 4)	Реализуйте базовый класс Car. У данного класса должны быть следующие атрибуты: speed, color, name, is_police (булево).
#     А также методы: go, stop, turn(direction), которые должны сообщать, что машина поехала, остановилась, повернула (куда).
#     Опишите несколько дочерних классов: TownCar, SportCar, WorkCar, PoliceCar.
#     Добавьте в базовый класс метод show_speed, который должен показывать текущую скорость автомобиля.
#     Для классов TownCar и WorkCar переопределите метод show_speed. При значении скорости свыше 60 (TownCar) и 40 (WorkCar) должно выводиться сообщение о превышении скорости.
# Создайте экземпляры классов, передайте значения атрибутов. Выполните доступ к атрибутам, выведите результат. Выполните вызов методов и также покажите результат.
class Car:
    car_speed: float
    car_color = "green"
    turn: str
    car_name: str
    car_is_police: bool

    def go(self, car_speed):
        if car_speed != 0:
            print(f"Едем")
        else:
            print("")

    def stop(self, car_speed):
        if car_speed != 0:
            print("")
        else:
            print("Не едем")

    def color(self):
        print(Car.car_color)

    # def car_turn(self, turn):
    #     self.turn = turn
    #     if turn = "left":
    #         print("turn left")
    #     if turn = "right":
    #         print("turn right")

    def show_speed(self, car_speed):
        print("Скорость автомобиля: ", car_speed)


FR = Car()
FR.go(0)
FR.stop(0)
FR.color()
# FR.car_turn("left")
FR.show_speed(250)

class TownCar(Car):
    town_car_speed = 100
    town_cat_seats = 5
    # def speed_control(self, car_speed):
    #     self.car_speed = car_speed
    #     if car_speed > 60
    #         print("Превышение скорости")
class SportCar(Car):
    sport_car_speed = 250
    sport_car_seats = 2
