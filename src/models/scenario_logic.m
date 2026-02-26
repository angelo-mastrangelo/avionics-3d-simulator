function [roc, pitch, deltaHdg] = scenario_logic(t, type)
    % Genera gli input automatici in base allo scenario selezionato
    switch type
        case 'Standard'
            if t < 10 % Decollo graduale
                roc = 2 + 0.8 * (t/10);
                pitch = 5 * sin((pi/2) * (t/10));
                deltaHdg = 0;
            elseif t < 20 % Crociera stabile
                roc = 0;
                pitch = 0;
                deltaHdg = 1; % Gira lentamente di 10° in totale
            else % Discesa controllata
                roc = -2 - 0.8 * ((t-20)/10);
                pitch = -5 * sin((pi/2) * ((t-20)/10));
                deltaHdg = 0;
            end
        case 'Turbolenza'
            roc = 2*sin(0.5*t) + 0.8*randn();
            pitch = 10*sin(0.4*t);
            deltaHdg = 5*sin(0.2*t);
        otherwise
            roc = 0; pitch = 0; deltaHdg = 0;
    end
end