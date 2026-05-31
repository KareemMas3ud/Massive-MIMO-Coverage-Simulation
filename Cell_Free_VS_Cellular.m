function MassiveMIMO_GUI()
    % =====================================================================
    % 1. Main Figure Initialization
    % =====================================================================
    fig = uifigure('Name', 'Massive MIMO Coverage Simulator', 'Position', [100, 100, 1150, 650]);
    fig.Color = [0.94 0.94 0.94]; 

    % =====================================================================
    % 2. PANEL 1: Simulation Parameters
    % =====================================================================
    pnlParams = uipanel(fig, 'Title', 'Simulation Parameters', ...
        'Position', [20, 420, 300, 200], 'FontSize', 12, 'FontWeight', 'bold', ...
        'BackgroundColor', [0.96 0.96 0.96], ...
        'BorderType', 'line', 'BorderWidth', 1.5);
    
    uilabel(pnlParams, 'Text', 'Area Size (m):', 'Position', [15, 130, 100, 22]);
    areaEdit = uieditfield(pnlParams, 'numeric', 'Position', [120, 130, 150, 22], 'Value', 1000);
    
    uilabel(pnlParams, 'Text', 'Number of APs:', 'Position', [15, 90, 100, 22]);
    apsEdit = uieditfield(pnlParams, 'numeric', 'Position', [120, 90, 150, 22], 'Value', 64);
    
    uilabel(pnlParams, 'Text', 'Tx Power (W):', 'Position', [15, 50, 100, 22]);
    powerEdit = uieditfield(pnlParams, 'numeric', 'Position', [120, 50, 150, 22], 'Value', 1);

    % Simulation Execution Button
    simBtn = uibutton(pnlParams, 'push', 'Text', 'Run Simulation', ...
        'Position', [60, 10, 180, 35], 'BackgroundColor', [0 0.45 0.74], ...
        'FontColor', 'w', 'FontSize', 14, 'FontWeight', 'bold', ...
        'ButtonPushedFcn', @(btn,event) runSimulation());

    % =====================================================================
    % 3. PANEL 2: Project & Team Details (Command Window Style)
    % =====================================================================
    pnlTeam = uipanel(fig, 'Title', 'Project Information', ...
        'Position', [20, 20, 300, 380], 'FontSize', 12, 'FontWeight', 'bold', ...
        'BackgroundColor', [0.96 0.96 0.96], ...
        'BorderType', 'line', 'BorderWidth', 1.5);
    
    % Formatting text exactly like the Command Window image
    infoText = sprintf([...
        '====================================\n' ...
        '   DIGITAL COMMUNICATION PROJECT    \n' ...
        '====================================\n\n' ...
        'Supervised By:\n' ...
        ' -> Dr. Mohammed Hammouda\n' ...
        ' -> Eng. Salma Samy\n\n' ...
        '====================================\n\n' ...
        'Prepared By:\n' ...
        ' -> Kareem Mohammed   (238253)\n' ...
        ' -> Rawan Habib       (235067)\n' ...
        ' -> Rawan Walaa       (209673)\n' ...
        ' -> Mahmoud Tarek     (229210)\n\n' ...
        '====================================']);
    
    % Using Monospaced font to keep the ASCII borders aligned perfectly
    uitextarea(pnlTeam, 'Value', infoText, 'Position', [10, 10, 280, 335], ...
        'Editable', 'off', 'FontSize', 12, 'FontName', 'Courier New', ...
        'BackgroundColor', [0.15 0.15 0.15], 'FontColor', [0.9 0.9 0.9]); % Dark background for terminal look

    % =====================================================================
    % 4. PANEL 3: Coverage Heatmaps Axes
    % =====================================================================
    pnlPlots = uipanel(fig, 'Title', 'Coverage Heatmaps (Signal Strength in dB)', ...
        'Position', [340, 20, 780, 600], 'FontSize', 12, 'FontWeight', 'bold', ...
        'BackgroundColor', [0.96 0.96 0.96], ...
        'BorderType', 'line', 'BorderWidth', 1.5);
    
    axCellular = uiaxes(pnlPlots, 'Position', [20, 80, 340, 450]);
    title(axCellular, 'Traditional Cellular Coverage');
    box(axCellular, 'on'); 
    
    axCellFree = uiaxes(pnlPlots, 'Position', [420, 80, 340, 450]);
    title(axCellFree, 'Cell-Free Distributed Coverage');
    box(axCellFree, 'on'); 

    % Run simulation automatically upon starting the GUI
    runSimulation();

    % =====================================================================
    % 5. Logic Function: Simulation & Plotting
    % =====================================================================
    function runSimulation()
        % Fetch values from GUI inputs
        area_size = areaEdit.Value;
        M = apsEdit.Value;
        pt = powerEdit.Value;
        alpha_pl = 3.5; % Path loss exponent
        
        % Generate spatial grid coordinates
        grid_resolution = 100;
        x = linspace(-area_size/2, area_size/2, grid_resolution);
        y = linspace(-area_size/2, area_size/2, grid_resolution);
        [X, Y] = meshgrid(x, y);
        
        % -----------------------------------------------------------------
        % Scenario A: Cellular Calculation
        % -----------------------------------------------------------------
        dist_cellular = sqrt(X.^2 + Y.^2);
        dist_cellular(dist_cellular < 1) = 1; 
        
        Rx_Cellular = (M * pt) ./ (dist_cellular.^alpha_pl);
        Rx_Cellular_dB = 10 * log10(Rx_Cellular);
        
        % Plotting Cellular
        contourf(axCellular, X, Y, Rx_Cellular_dB, 20, 'LineStyle', 'none');
        colormap(axCellular, 'turbo');%%%%%%%%%%%%%%%%%%%%%%%%%%
        hold(axCellular, 'on');
        plot(axCellular, 0, 0, 'w^', 'MarkerSize', 12, 'MarkerFaceColor', 'k');
        hold(axCellular, 'off');
        xlabel(axCellular, 'Distance (m)');
        ylabel(axCellular, 'Distance (m)');
        
        % Add Colorbar and fix limits so Tx Power changes are visible
        cb1 = colorbar(axCellular);
        cb1.Label.String = 'Received Power (dB)';
        clim(axCellular, [-120 0]); % Fixed color limits!
        
        % -----------------------------------------------------------------
        % Scenario B: Cell-Free Calculation
        % -----------------------------------------------------------------
        rng(42); % Fixed seed
        AP_pos = (rand(M, 2) - 0.5) * area_size;
        Rx_CellFree = zeros(size(X));
        
        for i = 1:M
            dist_AP = sqrt((X - AP_pos(i,1)).^2 + (Y - AP_pos(i,2)).^2);
            dist_AP(dist_AP < 1) = 1; 
            Rx_CellFree = Rx_CellFree + ((pt / M) ./ (dist_AP.^alpha_pl));
        end
        Rx_CellFree_dB = 10 * log10(Rx_CellFree);
        
        % Plotting Cell-Free
        contourf(axCellFree, X, Y, Rx_CellFree_dB, 20, 'LineStyle', 'none');
        colormap(axCellFree, 'turbo'); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        hold(axCellFree, 'on');
        plot(axCellFree, AP_pos(:,1), AP_pos(:,2), 'w*', 'MarkerSize', 5);
        hold(axCellFree, 'off');
        xlabel(axCellFree, 'Distance (m)');
        ylabel(axCellFree, 'Distance (m)');
        
        % Add Colorbar and fix limits to match Cellular
        cb2 = colorbar(axCellFree);
        cb2.Label.String = 'Received Power (dB)';
        clim(axCellFree, [-120 0]); % Fixed color limits to match!
    end
end