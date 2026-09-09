const int pinoSensorLM35 = A0;
float temperatura;

  void setup() {
    Serial.begin(9600);
  }

  void loop() {
    int valorLeitura = analogRead(pinoSensorLM35);
    temperatura = (valorLeitura * 0.00488);
    temperatura = temperatura * 100;

  // para declarar labels no plotter serial:
    Serial.print("TempMaximo:");
    Serial.print(8);
    Serial.print(" ");
    Serial.print("Temperatura:");
    Serial.print(temperatura - 15);
    Serial.print(" ");
    Serial.print("TempMinima:");
    Serial.println(2);

    delay(2000);
  }