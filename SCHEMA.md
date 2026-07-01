-- 1. Domains Table: Stores unique root domains (e.g., 'youtube.com')
CREATE TABLE domains (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  domain_name TEXT UNIQUE NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Global URLs Table: Stores the specific URL, OG data, and future AI data
CREATE TABLE global_urls (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  domain_id UUID REFERENCES domains(id) ON DELETE CASCADE,
  url_path TEXT NOT NULL,          -- e.g., '/watch?v=dQw4w9WgXcQ'
  full_url TEXT UNIQUE NOT NULL,   -- The complete URL for exact matching
  og_title TEXT,
  og_description TEXT,
  og_image_url TEXT,
  ai_inference_data JSONB,         -- Stored here later to reuse across all users
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 3. User Saves Table: Links a user to a global URL
CREATE TABLE user_saved_urls (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  global_url_id UUID REFERENCES global_urls(id) ON DELETE CASCADE,
  user_category TEXT,              -- Allows users to organize it their own way
  created_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(user_id, global_url_id)   -- Prevents a user from saving the same URL twice
);

-- 4. User Profiles Table: Tracks streaks and aggregated statistics
CREATE TABLE user_profiles (
  user_id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  current_streak INT DEFAULT 0,
  longest_streak INT DEFAULT 0,
  last_review_date DATE,
  total_saved INT DEFAULT 0,
  total_reviewed INT DEFAULT 0,
  recall_rate NUMERIC(5,2) DEFAULT 0.00,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 5. User Review Logs Table: Tracks individual review sessions for heatmap and stats
CREATE TABLE user_review_logs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  global_url_id UUID REFERENCES global_urls(id) ON DELETE CASCADE,
  recall_score INT,                -- e.g., 0 to 100, or a specific scale (forgot, hard, good, easy)
  reviewed_at TIMESTAMPTZ DEFAULT NOW()
);