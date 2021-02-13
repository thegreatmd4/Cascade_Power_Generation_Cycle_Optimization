function PlotCosts(pop)

    Costs=[pop.Cost];
    
    plot(Costs(1,:),Costs(2,:),'r*','MarkerSize',8);
    xlabel('Q_h');
    ylabel('Thermal Efficiency');
    grid on;

end