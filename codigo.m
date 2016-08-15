function parcial=codigo(valor)
clc;
disp('Estado de ejecucion de codigo:');
entrada=[];
for i=1:length(valor)
    entrada(i)=str2num(valor(i));
end
%entrada=[0 1 0 1 0 0 0 1 1 0 1];
%entrada=[1 1 1 1 0 0 0 0 1 1 0 0 1 0 1 0];

cadena=[];
puntero=1;
titulo='Cadena de bits: ';
for i=1:length(entrada)
    cadena(puntero)=entrada(i);
    cadena(puntero+1)=entrada(i);
    puntero=puntero+2;
    titulo=strcat(titulo,num2str(entrada(i)));
end

%UNRZ-----------------------------------------------------------------------
disp('Graficando Unipolar NRZ...');
for i=1:length(cadena)
    xValues=[(i-1) i];
    yValues=[cadena(i) cadena(i)];
    hold on;
    subplot(9,1,1)
    plot(xValues,yValues,'r') 
    axis([0 length(cadena) -2 2])
    ylabel('NRZ');
    grid on
    if (i~=length(cadena)) && (cadena(i)~=cadena(i+1))
        xValues=[i i];
        yValues=[0 1];
        line(xValues,yValues);
        hold on;
        plot(xValues,yValues,'r')
    end    
end
title(titulo);
%PNRZ-----------------------------------------------------------------------
disp('Graficando Polar NRZ...');
for i=1:length(cadena)
    if(cadena(i)==0)
        v1=-1;
    else
        v1=1;
    end
    xValues=[(i-1) i];
    yValues=[v1 v1];
    hold on;
    subplot(9,1,2)
    plot(xValues,yValues,'b') 
    axis([0 length(cadena) -2 2])
    ylabel('PNRZ');
    grid on
    if (i~=length(cadena)) && (cadena(i)~=cadena(i+1))
        xValues=[i i];
        yValues=[1 -1];
        line(xValues,yValues);
        hold on;
        plot(xValues,yValues,'b')
    end    
end

%Clock---------------------------------------------------------------------
disp('Graficando Clock...');
for i=1:length(cadena)
    if(mod(i,2)~=0)
        v1=1;
    else
        v1=0;
    end
    xValues=[(i-1) i];
    yValues=[v1 v1];   
    hold on;
    subplot(9,1,3)
    plot(xValues,yValues,'r') 
    axis([0 length(cadena) -2 2])
    ylabel('Clock');
    grid on
    xValues=[i i];
    yValues=[0 1];
    line(xValues,yValues);
    hold on;
    plot(xValues,yValues,'r')   
end

%Manchester----------------------------------------------------------------
disp('Graficando Manchester...');

clock=1;
for i=1:length(cadena)
    if cadena(i)==clock
        v1=-1;
    else
        v1=1;
    end
    xValues=[(i-1) i];
    yValues=[v1 v1];   
    hold on;
    subplot(9,1,4)
    plot(xValues,yValues,'b') 
    axis([0 length(cadena) -2 2])
    ylabel('Mter');
    grid on
    
    if i~=length(cadena) && cadena(i)==cadena(i+1)
        xValues=[i i];
        yValues=[-1 1];
        line(xValues,yValues);
        hold on;
        plot(xValues,yValues,'b') 
    end
    if clock==0
        clock=1;
    else
        clock=0;
    end
end

%Unipolar RZ---------------------------------------------------------------
disp('Graficando Unipolar RZ...');

validar=0;
for i=1:length(cadena)
    if cadena(i)==0 || validar==1
        v1=0;
        validar=0;
    else
        v1=1;
        if cadena(i)==1 && validar==0
            validar=1;
        end
    end
    xValues=[(i-1) i];
    yValues=[v1 v1];
    hold on;
    subplot(9,1,5)
    plot(xValues,yValues,'r') 
    axis([0 length(cadena) -2 2])
    ylabel('URZ');
    grid on
    if (i~=length(cadena)) && ((v1~=cadena(i+1)) || validar==1)
        xValues=[i i];
        yValues=[0 1];
        line(xValues,yValues);
        hold on;
        plot(xValues,yValues,'r')
    end    
end

%Bipolar RZ----------------------------------------------------------------
disp('Graficando Bipolar RZ...');

for i=1:length(cadena)

    if cadena(i)==0
        v1=-1;
    else 
        v1=1;
    end
    
    if mod(i,2)==0
        v1=0;
    end
    
    xValues=[(i-1) i];
    yValues=[v1 v1];
    hold on;
    subplot(9,1,6)
    plot(xValues,yValues,'b') 
    axis([0 length(cadena) -2 2])
    ylabel('BRZ');
    grid on
    
    xValues=[i i];
       
    if i~=length(cadena)
        if cadena(i)<cadena(i+1) || (cadena(i)==cadena(i+1) && v1==1) || (v1==0 && cadena(i+1)==1)
            yValues=[0 1];
        else
            yValues=[-1 0];
         end
    end
    line(xValues,yValues);
    hold on;
    plot(xValues,yValues,'b')
end

%AMI-----------------------------------------------------------------------
disp('Graficando AMI...');

val=0;
for i=1:length(cadena)
    if mod(i,2)~=0
        if cadena(i)==0
            v1=0;
        else
            if val==0
                v1=1;
                val=1;
            else
                v1=-1;
                val=0;
            end
        end
    end
    
    xValues=[(i-1) i];
    yValues=[v1 v1];
    hold on;
    subplot(9,1,7)
    plot(xValues,yValues,'r') 
    axis([0 length(cadena) -2 2])
    ylabel('AMI');
    grid on
    
    if mod(i,2)==0
        if i~=length(cadena)
            if cadena(i)==1 && cadena(i+1)==1
                xValues=[i i];
                yValues=[-1 1];
                line(xValues,yValues);
                hold on;
                plot(xValues,yValues,'r')
            end
            if (v1==1 && cadena(i+1)==0) || (v1==0 && cadena(i+1)==1 && val==0)
               xValues=[i i];
               yValues=[0 1];
               line(xValues,yValues);
               hold on;
               plot(xValues,yValues,'r')
            end
            if (v1==-1 && cadena(i+1)==0) || (v1==0 && cadena(i+1)==1 && val==1)
               xValues=[i i];
               yValues=[-1 0];
               line(xValues,yValues);
               hold on;
               plot(xValues,yValues,'r')
            end
        end
    end
end
%B8ZS-----------------------------------------------------------------------
disp('Graficando B8ZS...');
bitstream=cadena;
    pulse = 5;
    current_level = -pulse;
    positive_violation = [ '0' '0' '0' '+' '-' '0' '-' '+' ];
    negative_violation = [ '0' '0' '0' '-' '+' '0' '+' '-' ];

    bit = 1;
    while bit <= length(bitstream)

        bt=bit-1:0.001:bit;

        if bitstream(bit) == 0

            if consecutive_zeros(bitstream, bit) >= 8
 
                if current_level > 0
                    pattern = positive_violation;
                else
                    pattern = negative_violation;
                end

                for v_bit = 1:8
                    v_bt = (v_bit+bit-2):0.001:(v_bit+bit-1);
                    switch pattern(v_bit)
                        case '0'
                            y = zeros(size(v_bt));
                        case '+'
                            y = (v_bt<v_bit+bit-1) * pulse;
                            current_level = pulse;
                        case '-'
                            y = (v_bt<v_bit+bit-1) * -pulse;
                            current_level = -pulse;
                    end

                    try
                        if pattern(v_bit + 1) == '+'
                            y(end) = pulse;
                        elseif pattern(v_bit + 1) == '-'
                            y(end) = -pulse;
                        end
                    catch e
                            try
                                if bitstream(bit+8) == 1
                                    y(end) = -current_level;
                                end
                            catch e
                                y(end) = -current_level;
                            end
                    end
                    draw_pulse(v_bt, y, pulse, v_bit+bit-1, pattern(v_bit))
                end
                bit = bit + 8;
                continue
            else
                y = zeros(size(bt));
            end
        else
            current_level = -current_level;
            y = (bt<bit) * current_level;
        end

        try
            if bitstream(bit+1) == 1
                y(end) = -current_level;
            end
        catch e
            y(end) = -current_level;
        end

        draw_pulse(bt, y, pulse, bit, num2str(bitstream(bit)))
        bit = bit + 1;
    end
    grid on;
    axis([0 length(bitstream) -pulse*2 pulse*2]);
    ylabel('B8ZS');

    function draw_pulse(x, y, height, b, bit_label)
        subplot(9,1,8);
        plot(x, y, 'LineWidth', 1);
        hold on;
    end

    function num = consecutive_zeros(bitstream, pos)
        num = 0;
        for b = pos:length(bitstream)
            if bitstream(b) == 0
                num = num + 1;
            else
                return
            end
        end
    end

%HDB3-----------------------------------------------------------------------
disp('Graficando HDB3...');
xn=cadena;
yn=xn;                                          
num=0;                                          

num=0;                                           
yh=yn;                                           
sign=0;                                          
V=zeros(1,length(yn));                           
B=zeros(1,length(yn));                           
for k=1:length(yn)
    if yn(k)==0
       num=num+1;                               
         if num== 4                             
           num=0;                               
           yh(k)=1*yh(k-4);                     
           V(k)=yh(k);                     
           if yh(k)==sign                   
              yh(k)=-1*yh(k);              
              yh(k-3)=yh(k);                
              B(k-3)=yh(k);                 
              V(k)=yh(k);                   
              yh(k+1:length(yn))=-1*yh(k+1:length(yn));        
           end
           sign=yh(k);                         
         end
       else
          num=0;                            
      end
end                                         
re=[xn',yn',yh',V',B'];
subplot(9,1,9);
stairs([0:length(xn)-1],yh);
axis([0 length(xn) -2 2]);
ylabel('HDB3');
grid on
parcial=1;
disp('Fin de la ejecucion');
end