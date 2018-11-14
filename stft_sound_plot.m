function stft_sound_plot(signal, window_size, sampling_rate, nfft)

%% 
%% stft_sound_plot takes the FFT of a sequence of windows of an input
%% signal, plots each frequency spectrum in Hz, and plays them through
%% the speakers. The window size is supplied by the calling program,
%% as is the sampling rate to use for computation of CT freqeuncy as
%% well as for playback.
%% 
%% function stft_sound_plot(signal, window_size, sampling_rate, nfft)
%%
%% Calls: plot_frequency_content.m
%%
%% Input arguments: 
%% 
%%    signal: the signal whose windows are to be FFT'ed,  plotted, and
%%    	      played
%%    window_size: the length of the windows, in samples, to cut the input signal into
%%    sampling_rate: sampling rate to use to determine how to mark the upper limit of
%%    		     the horizontal axis in the plot as well as to
%%    		     play the sound
%%    nfft: (optional): length of the fft
%% 
%%  If nfft is not supplied it is set to the length of the signal
%%  
%%  Note that if the window size does not divide evenly into the
%%  length of the signal the last samples (the remainder of that
%%  division) are ignored
%% 
%%  Oct 2014
%%  V1.0
%% 
%%  V1.1
%%  Updates to make figures look better and to open new figure on each call
%%  Nov 2015
%%
%%  V1.2
%%  Updates to make sure ipput signal has no more than 2 channels and to
%%  force choice of just one if it has more than one
%%  Nov 2016
%%
%%  DH Brooks
%%

% check input and reduce to one channel if needed

[nrows,ncols] = size(signal);

% firs check to be sure no mor than 2 rows or columns

if min(nrows,ncols) > 2
   disp('ERROR: signal has too many rows or columns, is not a valid sound for this program') 
   return
end

if min(nrows,ncols) == 2
   disp('WARNING: signal has two channels, only using one here')
   if nrows == 2
      signal = signal(1,:);
   else
      signal = signal(:,1);
   end
end

% open new figure

figure

% get important initial parameters

siglength = length(signal);
num_samples_left = rem(siglength, window_size);
num_samples_to_use = siglength - num_samples_left;
num_windows = floor(siglength / window_size);

% calculate time vector in seconds 

time_in_seconds = [0:siglength-1] / sampling_rate;

%% and plot the signal itself

subplot(2,1,1)   %% top panel

plot(time_in_seconds,signal)
xlabel('Time, s')

axis([0  time_in_seconds(end)  1.1*min(signal)  1.1*max(signal) ])

hold on

% supply default if FFT length not supplied

if nargin < 4
   nfft = siglength;
end

%% now loop through the windows

for window_indx = 1: num_windows

%  mark each window on plot of original signal
  
     subplot(2,1,1)   % set to top plot
     hold on

% find start and end of this window

     start_window = (window_indx-1)* window_size + 1;
     end_window = window_indx * window_size ;

% convert to time in seconds

     start_window_secs = start_window / sampling_rate;
     end_window_secs = end_window / sampling_rate;

% plot lines in red to show where the window is on the original signal

     plot( [start_window_secs, start_window_secs],[min(signal),max(signal)],'r')
     plot( [end_window_secs, end_window_secs] , [min(signal),max(signal)],'r')
     title(['Signal: last pair of red lines show current window'])

% now move to lower plot

     subplot(2,1,2)

% extract this window of the signal

     this_window =  signal(start_window : end_window);

% plot its FFT in a nice format

     plot_frequency_content(this_window , sampling_rate, nfft)
     title('Magnitude of DFT of current window')

% play it back

     sound(signal((window_indx-1)* window_size + 1 : window_indx *  window_size), sampling_rate )


     if window_indx < num_windows

% do it again on next window !

        disp(['Hit return to go to window #',num2str(window_indx+1),': ']),
 	pause

     end  % if


end  % of loop over windows

return
