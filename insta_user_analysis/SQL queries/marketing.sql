
Use ig_clone;



/*
A) Marketing: The marketing team wants to launch some campaigns, and they need your help with the following
*/

/*
1.Rewarding Most Loyal Users: People who have been using the platform for the longest time.
Your Task: Find the 5 oldest users of the Instagram from the database provided
*/

select * From users 
order by created_at 
limit 5;

/*
2.Remind Inactive Users to Start Posting: By sending them promotional emails to post their 1st photo.
Your Task: Find the users who have never posted a single photo on Instagram
*/

select * from users u
left join photos p
on p.user_id = u.id
where p.image_url is null
order by u.username;


/*
3.Declaring Contest Winner: The team started a contest and the user who gets the most likes on a single photo will win the contest now they wish to declare the winner.
Your Task: Identify the winner of the contest and provide their details to the team
*/

select u.id, u.username, p.id as photo_id, COUNT(l.user_id) as likes_count
from users u
join photos p on u.id = p.user_id
left join likes l on p.id = l.photo_id
group by  u.id, u.username, p.id
order by  likes_count desc;




/*
4. Hashtag Researching: A partner brand wants to know, which hashtags to use in the post to reach the most people on the platform.
Your Task: Identify and suggest the top 5 most commonly used hashtags on the platform
*/

select tag_name, COUNT(*) as hashtag_count
from photo_tags
join tags on photo_tags.tag_id = tags.id
group by tag_name
order by hashtag_count desc
limit 5;



/*
5.Launch AD Campaign: The team wants to know, which day would be the best day to launch ADs.
Your Task: What day of the week do most users register on? Provide insights on when to schedule an ad campaign
*/

with my_cte as (
    select WEEKDAY(created_at) as weekDay
    from users
)
select weekDay, COUNT(*) as max_count
from my_cte
group by weekDay
order by max_count desc;



-- More practise question:-

/* 
1. Most Active Users:  
   - Find the top 5 users who have uploaded the most photos on the platform. 
*/

select u.id , u.username , count(u.username) as photos_uploaded  from users u
inner join photos p 
on p.user_id = u.id
group by u.id 
order by  photos_uploaded desc limit 5;


/*
2. Popular Users by Followers:  
   - Identify the users with the highest number of followers.  
*/

select  u.id,u.username ,count(f.follower_id) as no_of_people_followed from users u
join follows f 
on f.followee_id = u.id 
group by u.id
order by no_of_people_followed desc;

/*
3. Daily Registration Trend:  
   - Calculate the number of users who register daily to identify trends in platform activity.
*/


select date(created_at) as registration_date , count(id) as no_of_registration
from users
group by registration_date
order by no_of_registration desc;


/*
4. Engagement Analysis:  
   - Find the photo with the highest engagement (sum of likes and comments).  
*/

SELECT p.id AS photo_id, p.image_url, 
       COUNT(l.user_id) + COUNT(c.id) AS engagement
FROM photos p
LEFT JOIN likes l ON p.id = l.photo_id
LEFT JOIN comments c ON p.id = c.photo_id
GROUP BY p.id 
ORDER BY engagement DESC;




