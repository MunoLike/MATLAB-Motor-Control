clear;
a = arduino('COM5');
configurePin(a, 'D11', 'DigitalOutput');
for i=1:10
        writeDigitalPin(a,'D11', 1);
        pause(1);
        writeDigitalPin(a,'D11', 0);
        pause(1);
end
