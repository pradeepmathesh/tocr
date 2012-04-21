BEGIN{
i=1;
}
{
printf "%d %s\n",i,$2
i++;
}
END{
}
