FS = 1000;
t1 = linspace(0, (length(ecg1)-1)/FS, length(ecg1));

figure; plot(t1, ecg1, '-k');grid on;
title('Recording.wav');
xlabel('t, Time, s');ylabel('Probably volts?');

plot_frequency_content(ecg1, FS);
xzoom(0,5);

t2 = linspace(0, (length(ecg2)-1)/FS, length(ecg2));

figure; plot(t2, ecg2, '-k');grid on;
title('Recording.wav');
xlabel('t, Time, s');ylabel('Probably volts?');

plot_frequency_content(ecg2, FS);
xzoom(0,100);