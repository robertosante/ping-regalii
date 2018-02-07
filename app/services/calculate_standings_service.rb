CalculateStandingsService = Struct.new(:user, :challenger, :winner) do
    # K can change based on user rating, not implemented yet 
    # K = 40, for a player new to the rating list until the completion of events with a total of 30 games and for all players until their 18th birthday, as long as their rating remains under 2300.
    # K = 20, for players with a rating always under 2400.
    # K = 10, for players with any published rating of at least 2400 and at least 30 games played in previous events. Thereafter it remains permanently at 10.
    K_FACTOR = 40

    def proceed
        update_rating
    end

    def winner?(competitor)
        competitor == winner ? 1 : 0
    end

    private
    

        def update_rating
            user_rating = (user.rating + (K_FACTOR * (winner?(user) - expected_score(user.rating, challenger.rating)))).round.to_i
            challenger_rating = (challenger.rating + (K_FACTOR * (winner?(challenger) - expected_score(challenger.rating, user.rating)))).round.to_i
            update_two = Struct.new(:user, :challenger)
            returned_ratings = update_two.new(user_rating, challenger_rating)
        end

        def expected_score(user_rating, challenger_rating)
            1/(1+10**((challenger_rating - user_rating)/400.0))
        end

        

end