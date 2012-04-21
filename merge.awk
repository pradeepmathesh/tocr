BEGIN{
n = 0
while ( (getline line < "tamilset3")  > 0 ) {
		array[n] = line
		n++;
        }
i = 0
}
{
printf "%s %d %d %d %d %d\n",array[i],$2,$3,$4,$5,$6
i++;
}
END{
for(i = 0; i < n; i++)
{
#	print array[i]
#printf "%s %d %d %d %d %d\n",array[i],$2,$3,$4,$5,$6
}
}
