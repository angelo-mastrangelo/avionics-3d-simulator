function update_instruments(gui, alt, spd, roc, hdg, pitch)
    % Aggiorna visivamente tutti i gauge del cockpit (con limiti di sicurezza per evitare crash)
    if isvalid(gui.fig)
        gui.altGauge.Value = max(0, min(200, alt));
        gui.spdGauge.Value = max(0, min(100, spd));
        gui.varioGauge.Value = max(-10, min(10, roc));
        gui.compassGauge.Value = mod(hdg, 360); % Bussola circolare
        gui.pitchGauge.Value = max(-30, min(30, pitch));
    end
end