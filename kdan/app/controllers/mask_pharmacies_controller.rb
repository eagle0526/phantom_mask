class MaskPharmaciesController < ActionController::Base
  def index    

    if params[:pharmacy_id]
      @pharmacy = Pharmacy.find(params[:pharmacy_id])
      @mps = MaskPharmacy.by_pharmacy(params[:pharmacy_id])
    elsif params[:pharmacy_name]
      @pharmacy = Pharmacy.find_by(name: params[:pharmacy_name])
      @mps = MaskPharmacy.by_pharmacy_name(params[:pharmacy_name])
    else
      @mps = MaskPharmacy.all
    end    
    
    render json: @mps.map { |mp| mp.attributes.except('created_at', 'updated_at').merge({'mask_name' => mp.mask.name}).merge( {'pharmacy_name' => mp.pharmacy.name} ) }
    
  end

  def mask_count        
    min_price = params[:min_price]
    max_price = params[:max_price]    
    mask_count = params[:mask_count].to_i

    # 所有的藥局
    @pharmacies = Pharmacy.all
    # 給定價格區間，並印出藥局、口罩資料
    @mps = MaskPharmacy.within_price_range(min_price, max_price)

    @result = []        
    @pharmacies.each do |pharmacy|
      
      mask_pharmacies = @mps.select { |mp| mp.pharmacy_id == pharmacy.id }
      mask_pharmacies_count = mask_pharmacies.count      

      if mask_pharmacies_count >= mask_count
        status = 'more'
      else
        status = 'less'
      end

      @result << { 'pharmacy_name' => pharmacy.name, 'status' => status }
    end

    render json: @result
  end

  def name_relevance    
    pharmacy_name = params[:pharmacy]    
    mask_name = params[:mask]    

    # 抓到藥局名稱
    if pharmacy_name
      @pharmacies = Pharmacy.where("name LIKE ?", "%#{pharmacy_name}%").sort_by { |pharmacy| -relevance_score(pharmacy, pharmacy_name) }
      json_data = @pharmacies.map do |pharmacy|
        {
          name: pharmacy.name,
          cash_balance: pharmacy.cash_balance,
          opening_hours: pharmacy.opening_hours,
          relevance_score: relevance_score(pharmacy, pharmacy_name)
        }
      end
    # 抓到口罩名稱
    else
      @masks = Mask.where("name LIKE ?", "%#{mask_name}%").sort_by { |mask| -relevance_score(mask, mask_name) }      
      json_data = @masks.map do |mask|
        {
          name: mask.name,                    
          relevance_score: relevance_score(mask, mask_name)
        }
      end
    end

    render json: json_data
  end

  private  
  #   term 參數要傳"資料庫的藥局或口罩"、 search_term要傳"路徑搜尋"
  def relevance_score(term, search_term)
    name = term.name.downcase
    search_term = search_term.downcase

    # 計算相關度分數
    score = 0
    score += 10 if name.starts_with?(search_term)
    score += 5 if name.include?(search_term)
    score += 1 if name.end_with?(search_term)
    score
  end
end
