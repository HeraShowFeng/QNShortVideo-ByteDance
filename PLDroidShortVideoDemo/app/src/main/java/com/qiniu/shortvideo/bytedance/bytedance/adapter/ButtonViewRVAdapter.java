package com.qiniu.shortvideo.bytedance.bytedance.adapter;

import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;


import com.qiniu.shortvideo.bytedance.R;
import com.qiniu.shortvideo.bytedance.bytedance.model.ButtonItem;
import com.qiniu.shortvideo.bytedance.bytedance.utils.CommonUtils;
import com.qiniu.shortvideo.bytedance.bytedance.utils.ToasUtils;
import com.qiniu.shortvideo.bytedance.bytedance.view.ButtonView;

import java.util.HashSet;
import java.util.List;
import java.util.Set;


public class ButtonViewRVAdapter extends SelectRVAdapter<ButtonViewRVAdapter.ViewHolder> {
    private List<ButtonItem> mItemList;
    private OnItemClickListener mListener;

    private Set<Integer> mPointOnItems;

    public ButtonViewRVAdapter(List<ButtonItem> itemList, OnItemClickListener listener) {
        this(itemList, listener, 0);
    }

    public ButtonViewRVAdapter(List<ButtonItem> itemList, OnItemClickListener listener, int selectItem) {
        mItemList = itemList;
        mListener = listener;
        mSelect = selectItem;
        mPointOnItems = new HashSet<>();
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        return new ViewHolder(LayoutInflater.from(parent.getContext())
                .inflate(R.layout.item_button_item, parent, false));
    }

    @Override
    public void onBindViewHolder(final ViewHolder holder, final int position) {
        final ButtonItem item = mItemList.get(position);
        holder.bv.setIcon(item.getIcon());
        holder.bv.setTitle(item.getTitle());
        holder.bv.setDesc(item.getDesc());

        if (position == mSelect) {
            holder.bv.on();
        } else {
            holder.bv.off();
        }
        holder.bv.pointChange(mPointOnItems.contains(position));
        holder.itemView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (CommonUtils.isFastClick()) {
                    ToasUtils.show("too fast click");
                    return;
                }
                setSelect(position);
                mListener.onItemClick(item);
            }
        });
    }

    @Override
    public int getItemCount() {
        return mItemList.size();
    }

    public void setItemList(List<ButtonItem> itemList) {
        mItemList = itemList;
        notifyDataSetChanged();
    }

    public void onClose() {
        mPointOnItems.clear();
        mSelect = 0;
        notifyDataSetChanged();
    }

    public void onProgress(float progress) {
        if (mSelect != 0 &&
                ((progress != 0 && mPointOnItems.add(mSelect)) || // Need to show points and hide points before 需要显示点并且之前隐藏点
                        (progress == 0 && mPointOnItems.remove(mSelect)))) { // Need to hide points and show points before 需要隐藏点并且之前显示点
            notifyItemChanged(mSelect);
        }
    }

    class ViewHolder extends RecyclerView.ViewHolder {
        ButtonView bv;

        public ViewHolder(View itemView) {
            super(itemView);

            bv = (ButtonView) itemView;
        }
    }

    public interface OnItemClickListener {
        void onItemClick(ButtonItem item);
    }
}
