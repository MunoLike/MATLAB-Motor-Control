clear;
a = arduino('COM5');
configurePin(a, 'D11', 'PWM');
for i=1:10
    for j=0:255
        writePWMDutyCycle(a, 'D11', j/255);
    end
end
clear;