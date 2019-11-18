function [msg] = generateMotivation()
%GENERATEMOTIVATION Summary of this function goes here
%   Detailed explanation goes here
	msgs = ["Keep trying! ",...
			"""Every great dream begins with a dreamer. Always remember, you have within you the strength, the patience, and the passion to reach for the stars to change the world."" -Harriet Tubman ",...
			"""If something is important enough, even if the odds are against you, you should still do it."" - Elon Musk ",...
			"""Champions keep playing until they get it right."" - Billie Jean King",...
			"""I never dreamt of success. I worked for it."" - Este Lauder",...
			"""Please think about your legacy, because you''re writing it every day."" - Gary Vaynerchuck",...
			"""The secret of getting ahead is getting started. The secret of getting started is breaking your complex, overwhelming tasks into smaller manageable tasks, and then starting on the first one."" - Mark Twain",...
			"""What I've learned from running is that the time to push hard is when you?re hurting like crazy and you want to give up. Success is often just around the corner."" - James Dyson",...
			"""A pessimist sees the difficulty in every opportunity; an optimist sees the opportunity in every difficulty."" - Sir Winston Churchill",...
			"""Timing, perseverance, and 10 years of trying will eventually make you look like an overnight success."" - Biz Stone",...
			"""Opportunity is missed by most people because it is dressed in overalls and looks like work."" - Thomas Edison",...
			"""Fall seven times and stand up eight."" - Unknown",...
			"""Diligence is the mother of good luck."" - Benjamin Franklin",...
			"""Ambition is the path to success. Persistence is the vehicle you arrive in."" - Bill Bradley",...
			"""Success is walking from failure to failure with no loss of enthusiasm."" - Winston Churchill",...
			"""I have not failed. I?ve just found 10,000 ways that won''t work."" - Thomas A. Edison",...
			"""What seems to us as bitter trials are often blessings in disguise."" - Oscar Wilde",...
			"""The only place where success comes before work is in the dictionary."" - Vidal Sassoon",...
			"""Success does not consist in never making mistakes but in never making the same one a second time."", - George Bernard Shaw",...
			"""Motivation is what gets you started. Habit is what keeps you going."" - Jim Ryun",...
			"""Failure is the condiment that gives success its flavor."" - Truman Capote",...
			];
		
		nmsgs	= length(msgs);
		i		= randsample(nmsgs, 1, true, ones(1, nmsgs)/nmsgs);
		msg		= msgs(i) + " ";
		
		msg		= wrappedtext(msg,80);
end

