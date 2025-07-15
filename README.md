# Wireless-Receiver-Simulation
# Wireless Receiver Simulation (IEEE 802.11 - Non-HT PHY)

This MATLAB project simulates a basic wireless receiver using the IEEE 802.11 Non-HT (non-high throughput) PHY standard. It demonstrates key signal processing tasks such as:

- Channel Estimation
- Time-of-Arrival (ToA) Analysis
- Signal Detection and Data Recovery
- Bit Error Rate (BER) Calculation

## 📊 Features

- Simulates multipath Rayleigh fading and AWGN
- Uses the L-LTF (Legacy Long Training Field) for channel estimation
- Estimates time-of-arrival via cross-correlation
- Recovers transmitted bits and calculates BER

## 🛠 Technologies Used

- MATLAB (R2022b or later)
- WLAN Toolbox
- Communications Toolbox

## File Structure

- `WirelessReceiverSim.m`: Main MATLAB simulation file.




## 🧪 How to Run

1. Ensure you have the **WLAN Toolbox** and **Communications Toolbox** installed.
2. Open `WirelessReceiverSim.m` in MATLAB.
3. Run the script. It will:
   - Generate a random Wi-Fi packet
   - Pass it through a simulated channel
   - Estimate ToA
   - Perform channel estimation
   - Recover the data and calculate BER

## 📷 Output Samples

### ToA Estimation via Cross-Correlation

![ToA Plot](screenshots/correlation_plot.png)

### Console Output
Estimated Time-of-Arrival (ToA): 8.30 microseconds
Bit Error Rate (BER): 0.0030
