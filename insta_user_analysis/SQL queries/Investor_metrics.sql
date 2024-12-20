
Use ig_clone;

/*
B) Investor Metrics: Our investors want to know if Instagram is performing well and is not becoming redundant like Facebook, 
					 they want to assess the app on the following grounds
*/


/*
1.User Engagement: Are users still as active and post on Instagram or they are making fewer posts
Your Task: Provide how many times does average user posts on Instagram. Also, provide the total number of photos on Instagram/total number of users
*/

-- Average number of posts per user
select count(*) / count(distinct user_id) as avg_no_of_posts_per_user
from photos;

-- Total number of photos on Instagram / Total number of users

select count(image_url) as  Total_photos , count(distinct user_id) as total_users
from photos;


/*
2.Bots & Fake Accounts: The investors want to know if the platform is crowded with fake and dummy accounts
Your Task: Provide data on users (bots) who have liked every single photo on the site (since any normal user would not be able to do this
*/

select l.user_id
from likes l
join photos p on l.photo_id = p.id
group by l.user_id
having count(distinct l.photo_id) = (select count(id) from photos);




