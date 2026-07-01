Knowledge Management & Active Recall App
Overview
This application transforms how users consume and retain digital content, moving them from passive digital hoarding to dynamic learning. By seamlessly capturing URLs, generating programmatic previews, and using AI to build delayed active-recall quizzes, the app helps users actively remember what they read.

Core Features
Seamless Capture: Automatically detects and ingests URLs (articles) via the device clipboard or native share menus. Future versions will support videos, audio, eBooks, and events.

Instant Programmatic Previews: Extracts Open Graph (OG) metadata for instant UI previews without relying on expensive LLM calls.

Cost-Optimized AI Processing: Uses a smaller, efficient LLM exclusively for parsing text documents. Video, audio, and event links are simply parsed for metadata and categorized.

Active Recall & Interactive Widgets: Features delayed generation of summary snippets and multiple-choice quizzes, which are pushed directly to interactive home screen widgets for frictionless spaced repetition.

Gamification & Analytics: Encourages daily learning habits through a streak system, a 5-week review heatmap, and real-time recall rate tracking based on the user's performance history.

## UI Architecture
The application features a streamlined 3-tab layout to focus the user on learning:
1. **Home**: The central hub for capturing new links, tracking your daily streak, and launching active recall review sessions.
2. **Library**: A searchable repository of all saved content, automatically organized into AI-generated topics (e.g., Neuroscience, Economics).
3. **You (Profile)**: A progress dashboard featuring all-time learning stats, a review heatmap, and topic mastery tracking.

Tech Stack
Frontend: Flutter (Mobile & Web)

Backend / Database: Supabase (PostgreSQL)

AI Processing: Background job triggering a lightweight LLM.

Database Architecture
To minimize AI inference costs and API usage, the database uses a deduplication strategy. Metadata, AI tags, AI categories, and AI-generated quizzes are stored globally and shared among all users who save the same link.

domains: Stores unique root domains (e.g., youtube.com).

global_urls: Stores the specific URL path, OG metadata, and ai_inference_data. This ensures the AI only processes a unique URL once.

user_saved_urls: A junction table linking a user to a global_url_id, allowing them to maintain their personal saved list and custom categories.

user_profiles: Tracks individual user gamification metrics, including current streak, longest streak, last review date, and aggregated performance statistics.

user_review_logs: Stores individual review events, powering the 5-week review heatmap and calculating the user's all-time recall rate.

Database Optimization Best Practices
To ensure the application remains highly performant and fetching user-specific feeds remains cost-effective as the user base grows, the following PostgreSQL/Supabase optimizations are required:

Foreign Key Indexing: While primary keys are indexed automatically in PostgreSQL, foreign keys are not; you must manually add indexes to the user_id and global_url_id columns in your junction table to prevent the database from performing slow, full sequential scans.

Row-Level Security (RLS) Caching: When setting up RLS policies so users only see their own data, wrapping functions in a SELECT statement (e.g., (select auth.uid()) = user_id) allows the database optimizer to cache the result rather than recalculating it for every row, drastically improving speed on large tables.

Explicit Column Querying: Always explicitly list the exact columns you require in your database joins instead of using SELECT * to reduce the volume of data processed and transferred.

Sorting Optimization: Add indexes to columns frequently used for sorting (such as the created_at timestamp) so the database does not have to sort massive result sets from scratch when displaying the most recent activity.

The database performance and indexing strategies outlined in this README are based on standard Supabase and PostgreSQL optimization principles.