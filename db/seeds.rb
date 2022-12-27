# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Users
user1 = User.create(email: 'david_heinemeier_hansson@example.com',
                    full_name: 'David Heinemeier Hansson',
                    password: 'password1')

user2 = User.create(email: 'steve_ross_kellock@example.com',
                    full_name: 'Steve Ross Kellock',
                    password: 'password2')

# Posts
user1.posts.create(content: 'Hello World 1')
user1.posts.create(content: 'Hello World 2')
