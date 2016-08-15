function salida= letra2bin(valor)
clc;

binario=dec2bin(valor)
disp('--------------------------')
salida='';
[fila, columna]=size(binario)
for i=1:fila
    aux='';
    count=0;
    for j=1:columna
        aux=strcat(aux,num2str(binario(i,j)));
        if(binario(i,j)==dec2bin(1))
            count=count+1;
        end
    end
    if length(aux)<7
        for j=1:7-length(aux)
            aux=strcat('0',aux);
        end
    end
    if (mod(count,2)==0)
        
        aux=strcat('1',aux);
    else
        aux=strcat('0',aux);
    end
    aux;
    salida=strcat(salida,aux);
end

    
