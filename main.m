function main()
    % Aggiunge le sottocartelle al path di MATLAB
    addpath(genpath('src'));
    
    % 1. Inizializzazione Interfaccia Grafica
    gui = init_cockpit_gui();
    setappdata(gui.fig,'stop',false);
    
    % 2. Variabili di Stato
    pitchOffset = 0; heading = 0; yawRate = 0; speed = 0; isRunning = false;
    
    % 3. Assegnazione Eventi
    gui.fig.KeyPressFcn = @(~,event) handleKeys(event);
    gui.startBtn.ButtonPushedFcn = @(~,~) simulate();
    gui.stopBtn.ButtonPushedFcn = @(~,~) stop_sim();

    % --- CALLBACKS ---
    function stop_sim()
        if isvalid(gui.fig)
            setappdata(gui.fig,'stop',true);
        end
    end

    function handleKeys(event)
        if isvalid(gui.fig) && strcmp(gui.scenarioDrop.Value, 'Manuale')
            switch event.Key
                case 'uparrow',   pitchOffset = max(-30, pitchOffset + 1);
                case 'downarrow', pitchOffset = min(30, pitchOffset - 1);
                case 'leftarrow',  yawRate = -20;
                case 'rightarrow', yawRate = 20;
                case {'add', 'equal', 'm'}, speed = min(100, speed + 2);
                case {'subtract', 'n'},     speed = max(0, speed - 2);
            end
        end
    end

    function simulate()
        % Evita doppie esecuzioni
        if isRunning
            return; 
        end

        if isvalid(gui.fig)
            focus(gui.fig);
        end
        
        % BLOCCO TRY-CATCH: Sicurezza di livello industriale
        try
            isRunning = true;
            
            if isvalid(gui.fig)
                setappdata(gui.fig,'stop',false);
                scenario = gui.scenarioDrop.Value;
            else
                isRunning = false;
                return;
            end
            
            dt = 0.1; t = 0; i = 1;
            alt = 0; spd = 0; pitch = 0; hdg = 0; roc = 0; x = 0; y = 0; time = 0;
            heading = 0; 
            
            if strcmp(scenario,'Manuale')
                speed = 0;
                uialert(gui.fig, 'Usa le frecce SU/GIÙ per il pitch, DESTRA/SINISTRA per virare. Tasti "+" o "M" per dare gas.', 'Controlli');
            end % <--- ECCO L'END CHE MANCAVA!
            
            cla(gui.ax); % Pulisce le linee del volo precedente!
            grid(gui.ax, 'on'); 
            view(gui.ax, 3);
            xlabel(gui.ax,'X (m)'); ylabel(gui.ax,'Y (m)'); zlabel(gui.ax,'Altitudine (m)');
            title(gui.ax, ['Traiettoria 3D - Scenario: ', scenario]);
            hold(gui.ax, 'on');
            
            if strcmp(scenario,'Manuale')
                xlim(gui.ax, [-5000 5000]); ylim(gui.ax, [-5000 5000]);
            else
                xlim(gui.ax, [-1000 1000]); ylim(gui.ax, [-1000 1000]);
            end
            zlim(gui.ax, [0 200]);
            
            p3 = plot3(gui.ax, NaN, NaN, NaN, 'b', 'LineWidth', 2);
            
            % Ciclo di Simulazione
            while isvalid(gui.fig) && ~getappdata(gui.fig,'stop')
                t = t + dt;
                
                % Timeout scenari automatici (30 secondi)
                if ~strcmp(scenario, 'Manuale') && t > 30
                    break;
                end
                
                time(i) = t;
                
                % Logica input
                if strcmp(scenario, 'Manuale')
                    roc(i) = pitchOffset * 0.4;
                    pitch(i) = pitchOffset;
                    spd(i) = speed;
                    yaw_current = yawRate;
                    yawRate = 0; 
                else
                    [roc(i), pitch(i), deltaHdg] = scenario_logic(t, scenario);
                    yaw_current = deltaHdg;
                    spd(i) = min(80, (strcmp(scenario, 'Standard')*2*t) + (strcmp(scenario, 'Turbolenza')*i*0.8));
                end
                
                % Aggiornamento Modello Fisico
                prev_idx = max(1, i-1);
                [x(i), y(i), alt(i), heading] = kinematics_update(...
                    x(prev_idx), y(prev_idx), alt(prev_idx), heading, spd(i), roc(i), yaw_current, dt);
                hdg(i) = heading;
                
                % Rendering Grafico
                if isvalid(gui.fig)
                    update_instruments(gui, alt(i), spd(i), roc(i), hdg(i), pitch(i));
                    
                    if isvalid(p3)
                        set(p3, 'XData', x(1:i), 'YData', y(1:i), 'ZData', alt(1:i));
                        if i > 1
                            xlim(gui.ax, [min(x)-50, max(x)+50]);
                            ylim(gui.ax, [min(y)-50, max(y)+50]);
                        end
                        drawnow limitrate;
                    end
                end
                
                pause(dt);
                i = i + 1;
            end
            
            isRunning = false; % Sblocco a fine ciclo
            
            % Esportazione Dati
            if i > 1
                flightLog = table(time', alt', spd', roc', pitch', hdg', x', y', ...
                    'VariableNames', {'Time','Altitude','Speed','ROC','Pitch','Heading','X','Y'});
                writetable(flightLog, 'flightLog.csv');
                
                if isvalid(gui.fig)
                    uialert(gui.fig,'Simulazione completata. CSV salvato.','Fine');
                end
                plot_post_flight(flightLog);
            end
            
        catch ME
            % Se qualcosa va in errore (es. file non trovato), sblocca tutto e mostra l'errore!
            isRunning = false; 
            if isvalid(gui.fig)
                error_msg = sprintf('Errore: %s\nLinea: %d', ME.message, ME.stack(1).line);
                uialert(gui.fig, error_msg, 'Errore di Sistema');
            end
            rethrow(ME); % Stampa anche in console
        end
    end
end