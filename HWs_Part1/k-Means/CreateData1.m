function x=CreateData(m)
    

    x1A=1;
    x2A=1;
    xA=[x1A+randn(m,1) x2A+randn(m,1)];
    
    x1B=4; %5
    x2B=2;
    xB=[x1B+randn(m,1) x2B+randn(m,1)];
    
    x1C=2;
    x2C=5;
    xC=[x1C+randn(m,1) x2C+randn(m,1)];
    
    x=[xA
       xB
       xC];
end 