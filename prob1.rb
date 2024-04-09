require 'httparty'

def get_user_repos(username)
    url = "https://api.github.com/users/#{username}/repos"
    response = HTTParty.get(url)
    if response.success?
        return JSON.parse(response.body)
    else
        puts "Error: #{response.code} - #{response.message}"
        return nil
    end
end

def find_most_starred_repo(repos)
    most_starred_repo = repos.max_by { |repo| repo['stargazers_count'] }
    return most_starred_repo
end

def display_repo_info(repo)
    puts "Name: #{repo['name']}"
    puts "Description: #{repo['description'] || 'N/A'}"
    puts "Star Count: #{repo['stargazers_count']}"
    puts "URL: #{repo['html_url']}"
end

username = 'heygo67'
repos = get_user_repos(username)

if repos
    most_starred_repo = find_most_starred_repo(repos)
    puts "Most Starred Repository:"
    display_repo_info(most_starred_repo)
end
