function gui = init_cockpit_gui()
    % Crea la finestra principale e restituisce una struct con tutti gli handle
    gui.fig = uifigure('Name','Cockpit Simulatore','Position',[100 100 1200 700]);
    gui.ax = uiaxes(gui.fig, 'Position', [650 400 500 250]);
    
    uilabel(gui.fig,'Position',[20 650 150 22],'Text','Scenario di volo:');
    gui.scenarioDrop = uidropdown(gui.fig, 'Items',{'Manuale','Standard','Turbolenza'}, 'Position',[20 620 200 30]);
    
    % Strumenti
    uilabel(gui.fig,'Text','Altimetro','Position',[20 560 100 22]);
    gui.altGauge = uigauge(gui.fig,'circular','Position',[20 460 100 100],'Limits',[0 200]);
    
    uilabel(gui.fig,'Text','Velocità','Position',[140 560 100 22]);
    gui.spdGauge = uigauge(gui.fig,'circular','Position',[140 460 100 100],'Limits',[0 100]);
    
    uilabel(gui.fig,'Text','Variometro','Position',[260 560 100 22]);
    gui.varioGauge = uigauge(gui.fig,'circular','Position',[260 460 100 100],'Limits',[-10 10]);
    
    uilabel(gui.fig,'Text','Bussola','Position',[380 560 100 22]);
    gui.compassGauge = uigauge(gui.fig,'circular','Position',[380 460 100 100],'Limits',[0 360]);
    
    uilabel(gui.fig,'Text','Assetto (Pitch)','Position',[500 560 100 22]);
    gui.pitchGauge = uigauge(gui.fig,'circular','Position',[500 460 100 100],'Limits',[-30 30]);
    
    % Bottoni
    gui.startBtn = uibutton(gui.fig,'Text','Avvia','Position',[20 400 80 30]);
    gui.stopBtn = uibutton(gui.fig,'Text','Stop','Position',[120 400 80 30]);
    
    % Inizializzazione 3D Axes
    cla(gui.ax); view(gui.ax,3); grid(gui.ax,'on');
    xlabel(gui.ax,'X (m)'); ylabel(gui.ax,'Y (m)'); zlabel(gui.ax,'Altitudine (m)');
    title(gui.ax,'Traiettoria 3D in tempo reale');
    hold(gui.ax,'on');
end