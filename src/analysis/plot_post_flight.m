function plot_post_flight(flightLog)
    % Genera la dashboard finale con l'analisi dei dati di volo
    figure('Name','Analisi Post-Flight 3D','Position',[200 100 1000 600]);
    tiledlayout(3,2);
    
    nexttile; plot3(flightLog.X, flightLog.Y, flightLog.Altitude); grid on;
    title('Altitudine 3D'); xlabel('X'); ylabel('Y'); zlabel('m');
    
    nexttile; plot3(flightLog.X, flightLog.Y, flightLog.Pitch); grid on;
    title('Pitch 3D'); xlabel('X'); ylabel('Y'); zlabel('°');
    
    nexttile; plot3(flightLog.X, flightLog.Y, flightLog.ROC); grid on;
    title('Rateo 3D'); xlabel('X'); ylabel('Y'); zlabel('m/s');
    
    nexttile; plot3(flightLog.X, flightLog.Y, flightLog.Heading); grid on;
    title('Direzione 3D'); xlabel('X'); ylabel('Y'); zlabel('°');
    
    nexttile; plot3(flightLog.X, flightLog.Y, flightLog.Speed); grid on;
    title('Velocità 3D'); xlabel('X'); ylabel('Y'); zlabel('m/s');
end