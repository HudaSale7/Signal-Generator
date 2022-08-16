
Fs = input('inter the sampling frequency :  ');
St = input('inter the start of time scale :  ');
ed = input('inter the end of time scale :  ');
n = input('inter the number of break points :  ');
if(n == 0)
    position = [] ; 
else
    position = input('thier positions (in vector form) :  ');
end
T = linspace(St,ed,(ed-St)*Fs);
p = [St position ed];
x=[];
for i = 1:n+1
disp('choose the number of the signal');
disp('-------------------------------');
disp('1-DC signal');
disp('2-Ramp signal');
disp('3-General order polynomial');
disp('4-Exponential signal');
s = input('5-sinusoidal signal');
switch s
    case 1
        A = input('enter the Amplitude :  ');
        y = A*ones(1,(p(i+1)-p(i))*Fs);
    case 2
        a = input('inter the slope :  ');
        b = input('inter the intercept :  ');
        v = linspace(p(i),p(i+1),(p(i+1)-p(i))*Fs);
        y = a*v+b;
    case 3
        A = input('inter the Amplitude :  ');
        os = input('inter the power :  ');
        b = input('inter the intercept :  ');
        v = linspace(p(i),p(i+1),(p(i+1)-p(i))*Fs);
        y = A*(v.^os)+b;
    case 4
        A = input('inter the Amplitude :  ');
        os = input('inter the exponent :  ');
        v = linspace(p(i),p(i+1),(p(i+1)-p(i))*Fs);
        y = A*exp(os*v);
    case 5
         A = input('inter the Amplitude :  ');
         freq = input('inter the frequency :  ');
         ph = input('inter the phase :  ');
         v = linspace(p(i),p(i+1),(p(i+1)-p(i))*Fs);
         y = A*sin(2*pi*freq*v+ph);
end
x = [x y];
end
figure;
plot(T,x)
grid on

while true 
    disp('choose the number of the operation you want to perform on the signal');
    disp('--------------------------------------------------------------------');
    disp('1-Amplitude Scaling');
    disp('2-Time reversal');
    disp('3-Time shift');
    disp('4-Expanding the signal');
    disp('5-Compressing the signal');
    z = input('6-None\n');
    switch z
        case 1
            A = input('inter the scale value :  ');
            newx = x*A;
            figure;
            plot(T,newx)
            grid on
        case 2
            newT = T*-1;
            figure;
            plot(newT,x)
            grid on
        case 3
            sh = input('enter the shift value :  ');
            temp = (Fs*(ed-St)) - (Fs*abs(sh));
                if (sh > 0)
                  newx =[zeros(1,Fs*abs(sh)) x(1,1:temp)]; 
                elseif (sh < 0 )
                  newx =[x(1,abs(sh)*Fs+1:end) zeros(1,Fs*abs(sh))];  
                end
            figure;
            plot(T,newx)
            grid on
        case 4
            e = input('enter the expanding value :  ');
            newT = linspace(St*e,ed*e,((ed-St)*Fs)*e);
            newx=resample(x,e,1);
            figure;
            plot(newT,newx)
            grid on
        case 5
            c = input('enter the compressing value :  ');
            newT = linspace(St/c,ed/c,((ed-St)*Fs)/c);
            newx=downsample(x,c);
            figure;
            plot(newT,newx)
            grid on
        case 6 
            break ; 
    end    
end

disp('----------');
disp('Thank you!');



