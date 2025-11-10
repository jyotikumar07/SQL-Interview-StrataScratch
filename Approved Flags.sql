
-- User with most Approved Flags.

/*Which user flagged the most distinct videos that ended up approved by YouTube? 
 Output, in one column, their full name or names in case of a tie. 
 In the user's full name, include a space between the first and the last name. */
 
 
 With SelectedUsers as (
Select U.user_firstname as first_, U.user_lastname as last_, U.video_id as video
from user_flags U
left join flag_review F
on U.flag_id = F.flag_id
where F.reviewed_outcome = 'APPROVED' and F.reviewed_by_yt = 'TRUE'
),

distinct_videos as (

Select concat_ws( ' ', first_, last_) as fullname, 
       count(distinct video) as distinct_count
from SelectedUsers
group by fullname
),

rank_ as (
Select fullname,  dense_rank() over(order by distinct_count desc) as Rank_
from distinct_videos
)

select fullname from rank_ where Rank_ = 1;
