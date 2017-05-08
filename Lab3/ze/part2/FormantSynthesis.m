%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%          Instituto Superior Tecnico          %
%                                              %
%             Speech Processing                %
%                                              %
%               Laboratorio - 3                %
%   Part 2 - Formant synthesis using Matlab    %
%                                              %
%                  Grupo 8                     %
%                                              %
%      Student - Jose  Diogo    - Nr 75255     %
%      Student - Ruben Tadeia   - Nr 75268     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function synth = FormantSynthesis(vowel, f0, duration, intensity)
    %Loading file from wavesurfer
    load -ASCII O8.mat
    
    Fs = 8000;
    T0 = 1/f0;
    T0_samples = floor(Fs*T0); % Round towards minus infinity
    duration_samples = duration*Fs;
    poleMagnitude = 0.95;
    
    pulse_train = zeros(1, duration_samples);
    for i = 1:T0_samples:duration_samples
        pulse_train(i) = intensity;
    end

    synth = pulse_train;
    for i = 1:4
        Ck = -poleMagnitude^2;
        Bk = 2*poleMagnitude*cos(2*pi*O8(vowel, i)/Fs);
        Ak = 1 - Bk - Ck;
        synth = filter(Ak, [1 -Bk -Ck], synth);
        audiowrite('synth.wav',synth,Fs);
    end
end