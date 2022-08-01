-- write a query to provide the date for nth occurence of sunday from a given date.

-- sunday=1, sat=7

Declare todays_date date;
declare n int64;
set todays_date = '2022-05-22';
set n=4;

select date_add(todays_date, Interval (7-extract(dayofweek from todays_date))+((n-1)*7) DAY ) as day_of_week;