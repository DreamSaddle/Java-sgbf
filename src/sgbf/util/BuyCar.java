package sgbf.util;

import java.util.HashMap;

import sgbf.entity.GoodsInfo;

public class BuyCar {

	private HashMap<Integer, GoodsInfo> goodsMap = new HashMap<Integer, GoodsInfo>();
	private int mapSize = 0;
	
	public HashMap<Integer, GoodsInfo> getGoodsMap() {
		return goodsMap;
	}

	public int getMapSize() {
		return goodsMap.size();
	}

	public void setMapSize(int mapSize) {
		this.mapSize = goodsMap.size();
	}

	public void addGood(GoodsInfo good) {
		if (goodsMap.containsKey(good.getGoodsId())) {
			GoodsInfo good_ = goodsMap.get(good.getGoodsId());
			//刷新商品数量
			good_.setNum(good_.getNum()+good.getNum());
			
		} else {
			goodsMap.put(good.getGoodsId(), good);
		}
	}
	
	public void deleteGood(int goodId) {
		if (goodsMap.containsKey(goodId)) {
			goodsMap.remove(goodId);
		}
	}
}
