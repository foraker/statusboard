// Include the ESP8266 WiFi library. (Works a lot like the
// Arduino WiFi library.)
#include <ESP8266WiFi.h>

//////////////////////
// WiFi Definitions //
//////////////////////
const char WiFiSSID[] = "SSID";         // WiFi name
const char WiFiPSK[] = "WIFI_PASSWORD"; // WiFi password

/////////////////////
// Pin Definitions //
/////////////////////
const int LED_PIN = 5;      // Thing's onboard, green LED
const int DIGITAL_PIN = 12; // Digital pin to be read

/////////////////////////
// StatusBoard Details //
/////////////////////////
const char* host = "URL"; // Statusboard URL
const int port = 3000;    // StatusBoard port (default 3000 in development, 80 in production)

//////////////////////
// Bathroom Details //
//////////////////////
const int ROOM = 1;    // Bathroom number
bool OCCUPIED = false; // Assume bathroom is unoccupied when it turns on

///////////////////////////
// Function Declarations //
///////////////////////////
void initHardware();
void connectWiFi();
boolean sendUpdate();
void toggleOccupied();

void setup()
{
  initHardware();             // Setup input/output I/O pins
  connectWiFi();              // Connect to WiFi
  digitalWrite(LED_PIN, LOW); // LED on to indicate connect success
}

void loop()
{
  delay(200);

  if(digitalRead(DIGITAL_PIN) == OCCUPIED) {
    if(sendUpdate())
      toggleOccupied();
    delay(2000); //debouncing
  }
}

void toggleOccupied()
{
  OCCUPIED = !OCCUPIED;
  Serial.println("OCCUPIED: " + String(OCCUPIED));
}

boolean sendUpdate()
{
  WiFiClient client;

  Serial.print("connecting to ");
  Serial.println(host);
  if (!client.connect(host, port)) {
    Serial.println("connection failed");
    return false;
  }

  String url = "/api/bathroom_updates";
  String PostData = "bathroom_update[occupied]=" + String(!OCCUPIED) + "&bathroom_update[room]=" + String(ROOM);

  Serial.print("requesting URL: ");
  Serial.println(url);

  client.println("POST /api/bathroom_updates HTTP/1.1");
  client.println("Host: " + String(host));
  client.println("User-Agent: Arduino/1.0");
  client.println("Connection: close");
  client.print("Content-Length: ");
  client.println(PostData.length());
  client.println();
  client.println(PostData);

  client.stop();
  return true;
}

void connectWiFi()
{
  byte ledStatus = LOW;
  Serial.println();
  Serial.println("Connecting to: " + String(WiFiSSID));
  // Set WiFi mode to station (as opposed to AP or AP_STA)
  WiFi.mode(WIFI_STA);

  // WiFI.begin([ssid], [passkey]) initiates a WiFI connection
  // to the stated [ssid], using the [passkey] as a WPA, WPA2,
  // or WEP passphrase.
  WiFi.begin(WiFiSSID, WiFiPSK);

  // Use the WiFi.status() function to check if the ESP8266
  // is connected to a WiFi network.
  while (WiFi.status() != WL_CONNECTED)
  {
    // Blink the LED
    digitalWrite(LED_PIN, ledStatus); // Write LED high/low
    ledStatus = (ledStatus == HIGH) ? LOW : HIGH;

    // Delays allow the ESP8266 to perform critical tasks
    // defined outside of the sketch. These tasks include
    // setting up, and maintaining, a WiFi connection.
    delay(100);
    // Potentially infinite loops are generally dangerous.
    // Add delays -- allowing the processor to perform other
    // tasks -- wherever possible.
  }
  Serial.println("WiFi connected");
  Serial.print("IP address: ");
  Serial.println(WiFi.localIP());
  Serial.println();
}

void initHardware()
{
  Serial.begin(9600);
  pinMode(DIGITAL_PIN, INPUT_PULLUP); // Setup an input to read
  pinMode(LED_PIN, OUTPUT); // Set LED as output
  digitalWrite(LED_PIN, HIGH); // LED off
}
