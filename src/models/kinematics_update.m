function [x, y, alt, hdg] = kinematics_update(x, y, alt, hdg, spd, roc, yawRate, dt)
    % Aggiorna le equazioni del moto in base agli input di controllo
    hdg = hdg + yawRate * dt;
    hdg = mod(hdg, 360);
    
    alt = alt + roc * dt;
    dx = cosd(hdg) * spd * dt;
    dy = sind(hdg) * spd * dt;
    
    x = x + dx;
    y = y + dy;
end