#!/bin/bash
echo "---"
echo "OVERCLOCKING SCRIPT - NVIDIA CARDS"
echo "Benoit Lavorata, 2018"
echo "---"

echo "---"
echo "---"
echo "Before you continue, make sure you know what you are doing. Overclocking CAN DAMAGE your system"
echo "---"
echo "---"

modeName="OVERCLOCK"
memoryOffset="-9"
clockOffset="100"
performanceOn="1"
fanControl="1"
fanSpeed="70"

# Set up X server 
echo "Set up X server on display"
X :1 &
export DISPLAY=:1

echo ""
echo ">>>>>>> Mode $modeName"
echo "---"
echo "memoryOffset=$memoryOffset, clockOffset=$clockOffset, performanceOn=$performanceOn, fanControl=$fanControl, fanSpeed=$fanSpeed"
echo "---"

echo ""
echo "GPU #0"
nvidia-settings -a [gpu:0]/GpuPowerMizerMode=$performanceOn
nvidia-settings -a [gpu:0]/GPUGraphicsClockOffset[3]=$clockOffset
nvidia-settings -a [gpu:0]/GPUMemoryTransferRateOffset[3]=$memoryOffset
nvidia-settings -a [gpu:0]/GPUFanControlState=$fanControl
nvidia-settings -a [fan:0]/GPUTargetFanSpeed=$fanSpeed

echo ""
echo "GPU #1"
nvidia-settings -a [gpu:1]/GpuPowerMizerMode=$performanceOn
nvidia-settings -a [gpu:1]/GPUGraphicsClockOffset[3]=$clockOffset
nvidia-settings -a [gpu:1]/GPUMemoryTransferRateOffset[3]=$memoryOffset
nvidia-settings -a [gpu:1]/GPUFanControlState=$fanControl
nvidia-settings -a [fan:1]/GPUTargetFanSpeed=$fanSpeed

echo ""
echo "GPU #2"
nvidia-settings -a [gpu:2]/GpuPowerMizerMode=$performanceOn
nvidia-settings -a [gpu:2]/GPUGraphicsClockOffset[3]=$clockOffset
nvidia-settings -a [gpu:2]/GPUMemoryTransferRateOffset[3]=$memoryOffset
nvidia-settings -a [gpu:2]/GPUFanControlState=$fanControl
nvidia-settings -a [fan:2]/GPUTargetFanSpeed=$fanSpeed


echo "Kill X server on display"
killall X

echo "---"
echo "Finished !"
echo "---"