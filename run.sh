if rm -f monte-carlo && g++ monte-carlo.cpp -o monte-carlo -lm -fopenmp
then
	./monte-carlo
else
	echo "compile failed."
fi