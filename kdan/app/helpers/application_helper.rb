module ApplicationHelper
  def parse_opening_hours(opening_hours)
  
    days = %w[Mon Tue Wed Thur Fri Sat Sun]
    formatted_hours = {}
  
    if opening_hours.split("").include?("/")
        
      # 根據 / 分成前後
      opening_hours = opening_hours.split("/")
      # 用!把星期幾和時間分開，最後把二維陣列壓平
      opening_hours = opening_hours.map { |str| str.gsub(/(\d{2}:\d{2}\s*-\s*\d{2}:\d{2})/, '!\1').split("!").map { |str| str.strip } }.flatten
  
      first_range_day = opening_hours[0]
      first_range_time = opening_hours[1]      
      second_range_day = opening_hours[2]
      second_range_time = opening_hours[3]
        
        # 第一個時間段，有 - 的
      if first_range_day.include?("-")
        start_day = first_range_day.split("-")[0].strip
        end_day = first_range_day.split("-")[1].strip
        start_index = days.index(start_day)
        end_index = days.index(end_day)
        start_time = first_range_time.split("-")[0]
        end_time = first_range_time.split("-")[1]
          
        if start_index <= end_index          
          (start_index..end_index).each do |i|            
            formatted_hours[days[i]] = "#{start_time} - #{end_time}"
          end
        end
      # 第一個時間段，沒有 - 的
      else
        first_range_day.split(", ").each do |i|
          formatted_hours[i] = first_range_time          
        end        
      end
  
      # 第二個時間段
      second_range_day.split(", ").each do |i|
        formatted_hours[i] = second_range_time
      end      
        
    else        
      # 將 opening_hours 字串轉換成陣列，以便進行後續處理
      hours_array = opening_hours.split(' ')
  
      if opening_hours =~ /(\w+)\s*-\s*(\w+)\s*(\d{2}:\d{2})\s*-\s*(\d{2}:\d{2})/        
        start_day = $1
        end_day = $2
        start_time = $3
        end_time = $4
  
        start_index = days.index(start_day)
        end_index = days.index(end_day)
  
        # Mon就是檢索值0，Fri就是檢索值4
        # 如果今天起始日期小於結束日期
        if start_index <= end_index          
          (start_index..end_index).each do |i|            
            formatted_hours[days[i]] = "#{start_time} - #{end_time}"
          end
        end
  
      # 這一段是處理 Mon, Wed, Fri 這種的格式
      elsif                 
        opening_hours = opening_hours.gsub(/(\d{2}:\d{2}\s*-\s*\d{2}:\d{2})/, '!\1')
        opening_hours = opening_hours.split("!")        
        opening_hours[0].split(", ").each do |day|
          formatted_hours[day] = "#{opening_hours[1]}"
        end      
      end
    end
  
    # 處理沒有開放的日期
    days.each do |day|
      formatted_hours[day] ||= "未營業"
    end      
                
    formatted_hours    
  end
end