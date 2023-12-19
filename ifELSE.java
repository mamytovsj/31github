public class PositiveNegativeZero {
    public static void main(String[] args) {
        // Заданное число
        int number = 0;

        // Проверка условия с использованием оператора if-else
        if (number > 0) {
            System.out.println("Число " + number + " положительное.");
        } else if (number < 0) {
            System.out.println("Число " + number + " отрицательное.");
        } else {
            System.out.println("Число " + number + " равно нулю.");
        }
    }
}

